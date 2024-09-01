//
//  TodoDetails.swift
//  Orel_TodoApiFatch
//
//  Created by Anna Pinchuk on 01/09/2024.
//

import Foundation

class TodoDetails: Todo {
    
    var image: String? = nil
    
    init(image: String? = nil, userId: Int, id: Int, title: String, completed: Bool? = nil) {
        self.image = image
        super.init(userId: userId, id: id, title: title, completed: completed)
    }
    
    private enum configKeys: String, CodingKey {
        case image
        case userId
        case id
        case title
        case completed
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: configKeys.self)
        
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        
        let uid = try container.decodeIfPresent(Int.self, forKey: .userId)!
        let id = try container.decodeIfPresent(Int.self, forKey: .id)!
        let title = try container.decodeIfPresent(String.self, forKey: .title)!
        
        super.init(userId: uid, id: id, title: title)
    }
    
}
