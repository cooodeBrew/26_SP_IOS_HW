//
//  ViewController.swift
//  alert
//
//  Created by 阿清 on 3/2/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    let choices = [
        "Simple UIAlertViewController",
        "UIAlertViewController with Multiple Buttons",
        "UIAlertViewController with TextField"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = choices[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowValue = choices[indexPath.row]
        
        switch indexPath.row {
        case 0: // Simple alert
            let controller = UIAlertController(title: "Alert Controller",
                                               message: rowValue,
                                               preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            controller.addAction(cancelAction)
            controller.addAction(okAction)
            controller.preferredAction = cancelAction
            
            present(controller, animated: true)
        case 1: // With multiple buttons
            let controller = UIAlertController(title: "Alert Controller",
                                               message: rowValue,
                                               preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "One", style: .default, handler: alertHandler)
            let action2 = UIAlertAction(title: "Two", style: .default) {
                (action) in print("Two selected")
            }
            let action3 = UIAlertAction(title: "Three", style: .default)
            let action4 = UIAlertAction(title: "Four", style: .default)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            controller.addAction(action1)
            controller.addAction(action2)
            controller.addAction(action3)
            controller.addAction(action4)
            controller.addAction(cancelAction)
            controller.preferredAction = cancelAction
            
            present(controller, animated: true)
        case 2: // With textfield
            let controller = UIAlertController(title: "Alert Controller",
                                               message: rowValue,
                                               preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            
            // Dynamically create a UITextField
            controller.addTextField() {
                (textField) in
                textField.placeholder = "Enter something"
            }
            
            
            let okAction = UIAlertAction(title: "OK", style: .default) {
                (alert) in
                let enteredText = controller.textFields![0].text
                // 叹号的作用是强制解包，打的是optional里面的东西
                print(enteredText!)
            }
            
            controller.addAction(cancelAction)
            controller.addAction(okAction)
            controller.preferredAction = cancelAction
            
            present(controller, animated: true)
            
        default:
            makePopup(popupTitle: "You made a poor choice", popupMessage: "Choose more wisely in the future")
        }
    }
    
    func alertHandler(alert: UIAlertAction) {
        print("Message")
    }
    
    func makePopup(popupTitle:String, popupMessage:String) {
        let controller = UIAlertController(title: popupTitle, message: popupMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        controller.addAction(okAction)
        
        present(controller, animated: true)
    }


}

