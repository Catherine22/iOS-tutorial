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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personTableView.delegate = self
        personTableView.dataSource = self
        personTableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "personCell")
        
        // MARK: Realm - initialising
        do {
            // Realm file path
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            realm = try Realm()
            loadCategories()
        } catch {
            NSLog("Error Initialising Realm: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
        var cells: [Item]?
        var cellCounts: [Int] = []
        categories?.forEach({ (category) in
            category.items.forEach({ (item) in
                cells?.append(item)
            })
            cellCounts.append(category.items.count)
        })
        cell.itemLabel.text = cells?[indexPath.row].name
        
        var totalItems = 0
        var i = 0
        while i < cellCounts.count {
            totalItems += cellCounts[i]
            if totalItems >= indexPath.row {
                cell.categoryLabel.text = categories?[i].name
                break
            }
            i += 1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        categories?.forEach({ (category) in
            count += category.items.count
        })
        return count
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var categoryTextField = UITextField()
        var itemTextField = UITextField()
        let writeAction = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            if let categoryName = categoryTextField.text {
                if let itemName = itemTextField.text {
                    // new category
                    let category = Category()
                    category.name = categoryName
                    
                    // new item
                    let item = Item()
                    item.name = itemName
                    category.items.append(item)
                    
                    self.save(category: category)
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
    func save(category: Category) {
        do {
            try realm?.write {
                realm?.add(category)
            }
        } catch {
            NSLog("Error writting Realm: \(error)")
        }
        
        //Refresh the tableView
        personTableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm?.objects(Category.self)
        
        //Refresh the tableView
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
