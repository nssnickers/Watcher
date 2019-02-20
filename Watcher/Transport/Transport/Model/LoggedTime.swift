//
//  LoggedTime.swift
//  Watcher
//
//  Created by Маргарита on 19/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation


enum LoggedTimeStatus: String, Codable {
    case pending
    case approved
    case rejected
}


struct LoggedTimeComment: Codable {
    let text: String
    let createdAt: String
}


public struct LoggedTime: Codable {
    
    // MARK: - Pulic Properties
    
    let id: Int
    let projectId: Int
    let userId: Int
    let minutesSpent: Int
    let project: Project
    let date: String
    let status: LoggedTimeStatus
    let description: String
    let createdAt: String
    let updatedAt: String
    let comments: [LoggedTimeComment]?
}
