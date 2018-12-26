//
//  ViewController.swift
//  TodoeyWithRealm
//
//  Created by Catherine Chen on 22/11/2018.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController, UIPickerViewDelegate, UIImagePickerControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray:[MyTodoeyItem] = []
    var selectedCategory: SelectedCategory? {
        // loadItems() will be called if selectedCategory is not nil
        didSet {
            if selectedCategory!.queryAll {
                loadItems()
            } else {
                let request: NSFetchRequest<MyTodoeyItem> = MyTodoeyItem.fetchRequest()
                request.predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.category!.name!)
                request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                loadItems(with: request)
            }
        }
    }
    
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let row = itemArray[indexPath.row]
        cell.textLabel?.text = row.title
        if row.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !(itemArray[indexPath.row].done)
        
        if itemArray[indexPath.row].done {
            // Delete data from our Core Data, then call 'context.save()' to save data
            context.delete(itemArray[indexPath.row])
            // Does nothing for our Core Date, it merely update our itemArray which is used to populate our tableView
            itemArray.remove(at: indexPath.row)
        }
        
        //To trigger the top tableView delegate method again once we change the item's done property
        tableView.reloadData()
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add new Todoey Item", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var textField = UITextField()
        let writeAction = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            
            if let content = textField.text {
                let newItem = MyTodoeyItem(context: self.context)
                newItem.title = content
                newItem.done = false
                newItem.parentCategory = self.selectedCategory?.category
                self.itemArray.append(newItem)
                self.saveItems()
            }
        }
        
        alert.addAction(writeAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        // Solution 3: Core Data
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        //Refresh the tableView
        tableView.reloadData()
    }
    
    
    //MARK: - Load items
    // "with request:" => Modify 'request' parameter with an external parameter
    // External parameter: with; Internal parameter: request
    // "= MyTodoeyItem.fetchRequest()" => Set a default value
    func loadItems(with request: NSFetchRequest<MyTodoeyItem> = MyTodoeyItem.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}


//MARK: - SearchBar methods
// Split up the functionality of our ViewController, and we can have specific parts that are responsible for specific things.
extension TodoListViewController: UISearchBarDelegate {
    
    func updateTableView(text: String) {
        let request: NSFetchRequest<MyTodoeyItem> = MyTodoeyItem.fetchRequest()
        // [cd]: You can modify an operator using the key characters c and d within square braces to specify case and diacritic insensitivity respectively
        request.predicate = (selectedCategory?.queryAll == true)
            ? NSPredicate(format: "title CONTAINS[cd] %@", text)
            : NSPredicate(format: "parentCategory.name MATCHES %@ AND title CONTAINS[cd] %@", selectedCategory!.category!.name!, text)
        // Sort the data we get back in alphabetical order.
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
        //Refresh the tableView
        tableView.reloadData()
    }
    
    // This method will be triggered as "Enter" is typed
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            updateTableView(text: searchBar.text!)
//        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Reload all the data as users clear the Search Bar
        if searchBar.text?.count == 0 {
            if selectedCategory!.queryAll {
                loadItems()
            } else {
                let request: NSFetchRequest<MyTodoeyItem> = MyTodoeyItem.fetchRequest()
                request.predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.category!.name!)
                request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                loadItems(with: request)
            }
            
            DispatchQueue.main.async {
                // No longer have the cursor and also the keyboard should go away
                searchBar.resignFirstResponder()
            }
            
            //Refresh the tableView
            tableView.reloadData()
        } else {
            // Query data as users are typing to improve user experience.
            updateTableView(text: searchBar.text!)
        }
    }
}

