//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Catherine Chen (RD-TW) on 2018/12/25.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit
import CoreData

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
        let row = categoryArray[indexPath.row]
        cell.textLabel?.text = row.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt:\(indexPath)")
    }
    
    
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add new Category", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var textField = UITextField()
        let writeAction = UIAlertAction(title: "Add Category", style: .default) { (UIAlertAction) in

            if let title = textField.text {
                let newCategory = Category(context: self.context)
                newCategory.name = title
                self.categoryArray.append(newCategory)
                self.saveCategories()
                
            }
        }
        
        alert.addAction(writeAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data manipulation methods
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        //Refresh the tableView
        tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
    }
}
