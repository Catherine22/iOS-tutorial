//
//  ViewController.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 16/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoryTableView: UITableView!
    
    var realm: Realm? = nil
    var categories: Results<Category>?
    var selectedCategory: Category?
    var queryAll: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        categoryTableView.rowHeight = 80.0
        categoryTableView.separatorStyle = .none
        
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
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        createNewCategory()
    }
    
    func createNewCategory() {
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
                category.backgroundColorHex = UIColor.randomFlat.hexValue()
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

extension CategoryViewController: SwipeTableViewCellDelegate {
    
    // TODO: TableView - Set up each cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryLabel.text = (indexPath.row == 0) ? "ALL" : categories?[indexPath.row - 1].name
        cell.backgroundColor = (indexPath.row == 0) ? UIColor.white : UIColor(hexString: categories?[indexPath.row - 1].backgroundColorHex ?? "FFFFFF")
        cell.delegate = self
        return cell
    }
    
    // TODO: TableView - Handle swiping action
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        // skip ALL
        if indexPath.row == 0 {
            return nil
        }
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            let index = indexPath.row - 1
            self.deleteCategory(category: self.categories![index], at: index)
            self.categoryTableView.beginUpdates()
            self.categoryTableView.deleteRows(at: [indexPath], with: .fade)
            self.categoryTableView.endUpdates()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "trash-icon")
        
        return [deleteAction]
    }
}
