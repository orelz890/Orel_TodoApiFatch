//
//  SecondScreenViewController.swift
//  Orel_TodoApiFatch
//
//  Created by Anna Pinchuk on 01/09/2024.
//

import UIKit

class SecondScreenViewController: UIViewController {

    // Image View
    @IBOutlet weak var todoImageView: UIImageView!
    
    // Labels
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    
    var todoDetails: TodoDetails? = nil
    var address: String = ""
    var cellNumber: Int? = -1
    
    var dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adjust view to screen size
        adjustToScreenSize()
        
        // Set view content
        getContentFromApi()
    }
    
    private func getContentFromApi() {
        
        self.dispatchGroup.enter()
        
        // Fech data from api
        TodoApi.shared.fetchTodoDetails(apiAddress: self.address){
            result in
            switch result {
                case .success(let data):
                    self.todoDetails = data
                
                case .failure(let error):
                    print(error)
            }
            self.dispatchGroup.leave()
        }
        
        self.dispatchGroup.notify(queue: .main) {
            print("Got the specific details of cell: \(self.cellNumber!)")
            
            // Set content
            self.setContent()
        }
    }
    
    func configure(address: String, cellNumber: Int) {
        self.cellNumber = cellNumber
        self.address = address
    }
    
    private func adjustToScreenSize() {
        print("Need to implemet using constraints.")
    }
    
    
    private func setContent() {
        
        // Set Labels
        self.uidLabel.text = "\(self.todoDetails!.userId)"
        self.idLabel.text = "\(self.todoDetails!.id)"
        self.titleLabel.text = self.todoDetails!.title
        self.completedLabel.text = "\(self.todoDetails!.completed ?? false)"
        
        // Set Image
        setImage(imageString: self.todoDetails!.image)
        
    }
    
    private func setImage(imageString: String? = nil) {
        
        var imageStr: String
        
        if (imageString != nil) {
            imageStr = imageString!
        }
        else {
            imageStr = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4F-UrV1mXBv5oL9AJY55hFF58rG7kyab6jA&s"
//            self.todoImageView.image = UIImage(named: "no_image")
//            return
        }
        
        guard let url = URL(string: imageStr) else {
            print("Invalid image adress for cell: \(self.cellNumber!)")
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.todoImageView.image = image
                    }
                }
            }
        }
    }
    
    
}
