//
//  ProjectTableViewCell.swift
//  Watcher
//
//  Created by Маргарита on 14/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit


/// Ячейка проекта
final class ProjectTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet private weak var projectNameLabel: UILabel!
    
    // MARK: - Public Methods
    
    /// Метод, который устанавливает ячейку
    ///
    /// - Parameter name: название Project
    public func setupWithProjectName(_ name: String) {
        projectNameLabel?.text = name
    }
}
