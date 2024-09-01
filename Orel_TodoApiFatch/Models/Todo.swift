//
//  Todo.swift
//  Orel_TodoApiFatch
//
//  Created by Anna Pinchuk on 01/09/2024.
//

import Foundation


class Todo: Codable {
    
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool?
    
    init(userId: Int, id: Int, title: String, completed: Bool? = nil) {
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    
}
