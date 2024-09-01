//
//  TodoTableViewCell.swift
//  Orel_TodoApiFatch
//
//  Created by Anna Pinchuk on 01/09/2024.
//

import Foundation
import UIKit


class TodoTableViewCell: UITableViewCell {
    
    // Labels
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func setContent(todo: Todo){
        self.uidLabel.text = "\(todo.userId)"
        self.idLabel.text = "\(todo.id)"
        self.titleLabel.text = todo.title
        self.completedLabel.text = "\(todo.completed!)"
    }
}
