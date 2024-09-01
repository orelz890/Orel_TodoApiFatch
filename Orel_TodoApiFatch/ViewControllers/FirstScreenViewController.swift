//
//  ViewController.swift
//  Orel_TodoApiFatch
//
//  Created by Anna Pinchuk on 01/09/2024.
//

import UIKit

class FirstScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
        
    // Table View
    @IBOutlet weak var todosTableView: UITableView!
    
    private let dispatchGroup = DispatchGroup()
    
    var todos: [Todo] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        todosTableView.dataSource = self
        todosTableView.delegate = self
        
        adjustViewToScreenSize()
        
        setContent()
    }

    private func adjustViewToScreenSize() {
        print("Need to implement using constraints, If I will have time.")
    }
    
    
    func setContent() {
        self.dispatchGroup.enter()
        
        TodoApi.shared.fetchTodos() {
            result in
            switch result {
                case .success(let data):
                    self.todos = data
                case .failure(let error):
                    print(error)
            }
            self.dispatchGroup.leave()
        }
        
        self.dispatchGroup.notify(queue: .main) {
            print("Fatched items from TodosApi.")
            self.todosTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellNumber = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        
        // Set cell content
        cell.setContent(todo: todos[cellNumber])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellNumber = indexPath.row
        
        print("Cell \(cellNumber) selected")
        
        let secondScreenViewController = storyboard?.instantiateViewController(identifier: "SecondScreenViewController") as! SecondScreenViewController
        
        secondScreenViewController.configure(address: TodoApi.apiTodosUrlString + "/1", cellNumber: cellNumber)
           
        present(secondScreenViewController, animated: true)
    }

}

