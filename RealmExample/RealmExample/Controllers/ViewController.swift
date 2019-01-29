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
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        
        // MARK: Realm - initialising
        do {
            // Realm file path
            NSLog("Realm path: \(Realm.Configuration.defaultConfiguration.fileURL!)")
            realm = try Realm()
            loadCategories()
        } catch {
            NSLog("Error Initialising Realm: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryLabel.text = categories?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add new Category", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var categoryTextField = UITextField()
        let writeAction = UIAlertAction(title: "Add Category", style: .default) { (UIAlertAction) in
            if let categoryName = categoryTextField.text {
                var skipSaving = false
                self.categories?.forEach({ (category) in
                    if categoryName == category.name {
                        skipSaving = true
                        return
                    }
                })
                
                if skipSaving {
                    self.popUpAlert(title: "Warning", message: "Category existed", completion: nil)
                } else {
                    // Persistant data via Realm
                    self.save(categoryName: categoryName)
                }
            } else {
                self.popUpAlert(title: "Warning", message: "Please fill in a category", completion: nil)
            }
        }
        
        alert.addAction(writeAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            categoryTextField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    func popUpAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Whenever you see the word "in", you should always think the word "self"
        let restartAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            completion?()
        }
        
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Realm - Data Manipulation Methods
    func save(categoryName: String) {
        do {
            try realm?.write {
                let category = Category()
                category.name = categoryName
                realm?.add(category)
            }
            
            // Refresh the tableView
            categoryTableView.reloadData()
        } catch {
            NSLog("Error writting Realm: \(error)")
        }
    }
    
    func loadCategories() {
        // MARK: Realm - Data Manipulation Methods
        categories = realm?.objects(Category.self)
        categoryTableView.reloadData()
    }
    
}

extension String {
    static func isInt(_ string: String) -> Bool {
        return Int(string) != nil
    }
}
