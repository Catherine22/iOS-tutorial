//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Catherine Chen (RD-TW) on 2018/12/25.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit
import RealmSwift

// TableView => ["All", category1, category2, ...]
// categoryArray => [category1, category2, ...]
class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToTodoyeItems", sender: self)
    }
    
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add new Category", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var textField = UITextField()
        let writeAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            
            if let title = textField.text {
                let newCategory = Category()
                newCategory.name = title
                self.saveCategory(category: newCategory)
            }
        }
        
        alert.addAction(writeAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new Category"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data manipulation methods
    func saveCategory(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving categories \(error)")
        }
        
        //Refresh the tableView
        tableView.reloadData()
    }
    
    func loadCategories() {
        categoryArray = realm.objects(Category.self)
        
        //Refresh the tableView
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToTodoyeItems" {
            let destinationVC = segue.destination as! TodoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
//                destinationVC.selectedCategory = categoryArray!
            }
        }
    }
}
