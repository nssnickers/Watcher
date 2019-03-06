//
//  DateFormatterManager.swift
//  Watcher
//
//  Created by Маргарита on 28/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

struct DateFormatterManager {

    static var baseDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }
    
    static var dayDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        return dateFormatter
    }
    
    static var hourMinutesDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter
    }
    
    static var dayMonthDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        
        return dateFormatter
    }
    
    static var dayLiteralMonthDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        
        return dateFormatter
    }
    
    static var weekDayLiteralDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter
    }
    
    private init() {}
}
