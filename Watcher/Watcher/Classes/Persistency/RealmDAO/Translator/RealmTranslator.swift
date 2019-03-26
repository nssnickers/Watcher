//
//  RealmTranslator.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation


class RealmTranslator <RLMModel: RealmEntity, Model: Entity> {
    
    func getRealmEntityFromEntity(_ entity: Model) -> RLMModel {
        return RLMModel()
    }
    
    func getEntityFromRealmEntity(_ realmEntity: RLMModel) -> Model {
        return Model()
    }
}
