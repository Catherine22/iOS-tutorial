//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Catherine Chen (RD-TW) on 2018/12/25.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit
import CoreData

// TableView => ["All", category1, category2, ...]
// categoryArray => [category1, category2, ...]
class CategoryTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray:[Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "All"
        } else {
            cell.textLabel?.text = categoryArray[indexPath.row - 1].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count + 1 // + 1 header
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
                let newCategory = Category(context: self.context)
                newCategory.name = title
                self.categoryArray.append(newCategory)
                self.saveCategories()
                
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
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving categories \(error)")
        }
        
        //Refresh the tableView
        tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToTodoyeItems" {
            let destinationVC = segue.destination as! TodoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let queryAll = indexPath.row == 0
                let category = queryAll ? nil : categoryArray[indexPath.row - 1]
                destinationVC.selectedCategory = SelectedCategory(category: category, queryAll: queryAll)
            }
        }
    }
}
