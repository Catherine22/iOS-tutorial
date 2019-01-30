//
//  ViewController.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 16/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var realm: Realm? = nil
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categories: Results<Category>?
    var selectedCategory: Category?
    var queryAll: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        
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
    
    // TODO: TableView - Set up each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryLabel.text = (indexPath.row == 0) ? "ALL" : categories?[indexPath.row - 1].name
        return cell
    }
    
    // TODO: TableView - Set up the amount of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let amount = categories?.count ?? 0
        return amount + 1 // with the first category - ALL
    }
    
    // TODO: TableView - Click event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            queryAll = true
        } else {
            queryAll = false
            selectedCategory = categories?[indexPath.row - 1]
        }
        performSegue(withIdentifier: "GoToItemsView", sender: self)
    }
    
    // TODO: TableView - Swipe to remove cells
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // TODO: TableView - Swipe to remove cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCategory(category: categories![indexPath.row], at: indexPath.row)
            categoryTableView.beginUpdates()
            categoryTableView.deleteRows(at: [indexPath], with: .fade)
            categoryTableView.endUpdates()
        }
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add new Category", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var categoryTextField = UITextField()
        let writeAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(writeAction)
        alert.addAction(cancelAction)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToItemsView" {
            // We are not allowed to create a ViewController Object regularly, like
            // let destinationVC = SecondViewController()
            // Instead, we do
            let destinationVC = segue.destination as! ItemViewController
            destinationVC.queryAll = queryAll
            destinationVC.selectedCategory = selectedCategory
        }
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
            NSLog("Error writing Realm: \(error)")
        }
    }
    
    // MARK: Realm - DataManipulation Methods
    func deleteCategory(category: Category, at index: Int) {
        do {
            try realm?.write {
                realm?.delete(category)
            }
        } catch {
            NSLog("Error writing Realm: \(error)")
        }
    }
    
    // MARK: Realm - Data Manipulation Methods
    func loadCategories() {
        categories = realm?.objects(Category.self)
        categoryTableView.reloadData()
    }
    
}
