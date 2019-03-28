//
//  RealmDAO.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import RealmSwift

// swiftlint:disable force_try
open class RealmDAO<Model: Entity, RealmModel: RealmEntity>: DAO<Model> {

    
    private let translator: RealmTranslator<RealmModel, Model>
    
    
    public init(_ translator: RealmTranslator<RealmModel, Model>) {
        self.translator = translator
    }
    
    
    override public func create(_ entity: Model) throws {
        let realm = try! Realm()
        
        try! realm.write {
            let realmEntity = self.translator.getRealmEntityFromEntity(entity)
            realm.add(realmEntity, update: true)
        }
    }
    
    
    override public func read(_ entityId: String) throws -> Model? {
        let realm = try! Realm()
        
        guard let realmEntity = realm.object(ofType: RealmModel.self, forPrimaryKey: entityId) else {
            return nil
        }
        
        return translator.getEntityFromRealmEntity(realmEntity)
    }
    
    
    override public func update(_ entity: Model) throws {
        let realm = try! Realm()
        
        try realm.write {
            let realmEntity = self.translator.getRealmEntityFromEntity(entity)
            realm.create(RealmEntity.self, value: realmEntity, update: true)
        }
    }
    
    
    override public func delete(_ entityId: String) throws {
        let realm = try! Realm()
        
        guard let entity = try read(entityId) else {
            return
        }
        
        let realmEntity = self.translator.getRealmEntityFromEntity(entity)
        realm.delete(realmEntity)
    }
    
    
    public func filter(_ filter: String) throws -> [Model]? {
        let realm = try! Realm()
        let realmModels = realm.objects(RealmModel.self).filter(filter)
        
        return realmModels.map({ translator.getEntityFromRealmEntity($0) })
    }
}
// swiftlint:enable force_try
