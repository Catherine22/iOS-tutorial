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
    
    var categories: Results<Category>?
    var cells = [Cell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personTableView.delegate = self
        personTableView.dataSource = self
        personTableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "personCell")
        
        // MARK: Realm - initialising
        do {
            // Realm file path
//            print(Realm.Configuration.defaultConfiguration.fileURL!)
            realm = try Realm()
            loadCategories()
        } catch {
            NSLog("Error Initialising Realm: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
        cell.categoryLabel.text = cells[indexPath.row].categoryName
        cell.itemLabel.text = cells[indexPath.row].itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var categoryTextField = UITextField()
        var itemTextField = UITextField()
        let writeAction = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            if let categoryName = categoryTextField.text {
                if let itemName = itemTextField.text {
                    
                    // Persistant data via Realm
                    self.save(categoryName: categoryName, itemName: itemName)
                } else {
                    NSLog("Item cannot be nil")
                }
            } else {
                NSLog("Category cannot be nil")
            }
        }
        
        alert.addAction(writeAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            categoryTextField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            itemTextField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Realm - Data Manipulation Methods
    func save(categoryName: String, itemName: String) {
        do {
            try realm?.write {
                // individual category
                var category = Category()
                category.name = categoryName
                self.categories?.forEach({ (c) in
                    if c.name == categoryName {
                        category = c
                        return
                    }
                })
                
                // new item
                let item = Item()
                item.name = itemName
                category.items.append(item)
                realm?.add(category)
            }
            
            // Refresh the tableView
            cells.append(Cell(categoryName: categoryName, itemName: itemName))
            personTableView.reloadData()
        } catch {
            NSLog("Error writting Realm: \(error)")
        }
    }
    
    func loadCategories() {
        // MARK: Realm - Data Manipulation Methods
        categories = realm?.objects(Category.self)
        
        
        //Refresh the tableView
        categories?.forEach({ (c) in
            c.items.forEach({ (i) in
                cells.append(Cell(categoryName: c.name, itemName: i.name))
            })
        })
        personTableView.reloadData()
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
