//
//  RealmDAO.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


final class RealmDAO<Model: Entity, RealmModel: RealmEntity>: DAO<Model> {
    
    // swiftlint:disable force_try
    private var realm = try! Realm()
    // swiftlint:enable force_try
    
    private let translator: RealmTranslator<RealmModel, Model>
    
    
    init(_ translator: RealmTranslator<RealmModel, Model>) {
        self.translator = translator
    }
    
    
    override func create(_ entity: Model) throws {
        // swiftlint:disable force_try
        try! realm.write {
        // swiftlint:enable force_try
            let realmEntity = self.translator.getRealmEntityFromEntity(entity)
            realm.add(realmEntity)
        }
    }
    
    
    override func read(_ entityId: String) throws -> Model? {
        guard let realmEntity = realm.object(ofType: RealmModel.self, forPrimaryKey: entityId) else {
            return nil
        }
        
        return translator.getEntityFromRealmEntity(realmEntity)
    }
    
    
    override func update(_ entity: Model) throws {
        try realm.write {
            let realmEntity = self.translator.getRealmEntityFromEntity(entity)
            realm.create(RealmEntity.self, value: realmEntity, update: true)
        }
    }
    
    
    override func delete(_ entityId: String) throws {
        guard let entity = try read(entityId) else {
            return
        }
        
        let realmEntity = self.translator.getRealmEntityFromEntity(entity)
        realm.delete(realmEntity)
    }
    
    
    func filter(_ filter: String) throws -> [Model]? {
        let realmModels = realm.objects(RealmModel.self).filter(filter)
        
        return realmModels.map({ translator.getEntityFromRealmEntity($0) })
    }
}
