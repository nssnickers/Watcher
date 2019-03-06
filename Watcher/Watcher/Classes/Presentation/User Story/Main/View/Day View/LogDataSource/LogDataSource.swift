//
//  LogDataSource.swift
//  Watcher
//
//  Created by Маргарита on 05/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import UIKit

private let dayCellReuseIdentifier = "LogCell" //как не повторять это значение в двух файлах?

final class LogDataSource: NSObject, UICollectionViewDataSource {
    
    private var logs: [LogViewModel]
    
    init(logs: [LogViewModel] = []) {
        self.logs = logs
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logs.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: dayCellReuseIdentifier,
                for: indexPath) as! LogCollectionViewCell
        // swiftlint:enable force_cast
        
        if logs.indices.contains(indexPath.item) {
            let log = logs[indexPath.item]
            cell.setupWithLog(log)
        }
            
        return cell
    }
}
