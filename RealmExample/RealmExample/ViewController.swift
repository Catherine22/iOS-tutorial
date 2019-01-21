//
//  ViewController.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 16/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var realm: Realm? = nil
    @IBOutlet weak var personTableView: UITableView!
    
    
    var itemArray: [DataModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personTableView.delegate = self
        personTableView.dataSource = self
        personTableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "personCell")
        
        // MARK: Realm - initialising
        do {
            realm = try Realm()
            loadItems()
        } catch {
            NSLog("Error Initialising Realm: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
        cell.title.text = itemArray?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 0
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var textField = UITextField()
        let writeAction = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            
            if let content = textField.text {
                self.saveItem(name: content, age: 10)
            }
        }
        
        alert.addAction(writeAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Realm - Write
    func saveItem(name: String, age: Int) {
        do {
            try realm?.write {
                let dataModel = DataModel()
                dataModel.name = name
                self.itemArray?.append(dataModel)
            }
        } catch {
            NSLog("Error writting Realm: \(error)")
        }
        
        //Refresh the tableView
        personTableView.reloadData()
    }
    
    func loadItems() {
        if let dataModels = realm?.objects(DataModel.self) {
            for dataModel in dataModels {
                itemArray?.append(dataModel)
            }
        }
    }
    
    

//
//    popUpAlert(title: "Warning", message: "Please fill in the blanks", completion: nil)
    
    func popUpAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Whenever you see the word "in", you should always think the word "self"
        let restartAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            completion?()
        }
        
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension String {
    static func isInt(_ string: String) -> Bool {
        return Int(string) != nil
    }
}
