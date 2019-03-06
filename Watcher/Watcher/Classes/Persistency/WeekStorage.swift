//
//  WeekStorage.swift
//  Watcher
//
//  Created by Маргарита on 06/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport // TODO: не должно быть известно о транспорте

// TODO: переделать все по аналогии с транспортом (сделать клиент и ендпоинты) и вынести в отдельный таргет, написать фасады, которые закрывают само хранилище

class WeekStorage {
    
    func getWeekByRange(_ range: LogTimeRange) -> WeekModel? {
        let defaults = UserDefaults.standard
        let weekKey = "\(range.from)-\(range.to)"
        
        if let savedWeek = defaults.object(forKey: weekKey) as? Data {
            let decoder = JSONDecoder()
            
            if let decodedWeek = try? decoder.decode(WeekModel.self, from: savedWeek) {
                return decodedWeek
            }
        }
        
        return nil
    }
    
    
    func setWeek(_ week: WeekModel) -> Bool {
        let encoder = JSONEncoder()
        
        if let encodedWeek = try? encoder.encode(week) {
            let defaults = UserDefaults.standard
            let weekKey = "\(week.fromDate)-\(week.toDate)"
            
            defaults.set(encodedWeek, forKey: weekKey)
            return true
        }
        
        return false
    }
}
