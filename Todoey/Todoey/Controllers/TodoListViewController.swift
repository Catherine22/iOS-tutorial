//
//  ViewController.swift
//  Todoey
//
//  Created by Catherine Chen on 22/11/2018.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController, UIPickerViewDelegate, UIImagePickerControllerDelegate {
    
    // Solution 1 & 2
//    var itemArray:[TodoeyItem] = []
    // Solution 1: UserDefault
    // Deprecated: we don't use UserDefaults in this case
//    let defaults = UserDefaults.standard
    
    // Solution 2: FileManager
    // Instead of using the default plist, we're going to create our own plist.
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // Solution 3: Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray:[MyTodoeyItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
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
//        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !(itemArray[indexPath.row].done)
        
        // Solution 3: Core Data
        if itemArray[indexPath.row].done {
            // Delete data from our Core Data, then call 'context.save()' to save data
            context.delete(itemArray[indexPath.row])
            // Does nothing for our Core Date, it merely update our itemArray which is used to populate our tableView
            itemArray.remove(at: indexPath.row)
        }
        
        //To trigger the top tableView delegate method again once we change the item's done property
        tableView.reloadData()
        // Solution 1 & 2
//        persistentData(newDataSource: itemArray)
        // Solution 3: Core Data
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add new Todoey Item", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var textField = UITextField()
        let writeAction = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            print("clicked")
            
            if let content = textField.text {
                // Solution 2: FileManager
//                self.itemArray.append(TodoeyItem(title: content, done: false))
//                self.persistentData(newDataSource: self.itemArray)
                
                // Solution 3: Core Data
                let newItem = MyTodoeyItem(context: self.context)
                newItem.title = content
                newItem.done = false
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
    
    //MARK: - Persistent the array
//    func persistentData(newDataSource: [TodoeyItem]) {
//        // Solution 1: UserDefault
//        // Deprecated: we don't use UserDefaults in this case
////        var flatArray: [String] = []
////        for (item) in newDataSource {
////            flatArray.append(item.toString()!)
////        }
////
////        self.defaults.set(flatArray, forKey: "TodoListArray")
//
//        // Solution 2: FileManager
//        print("Saved item array in \(String(describing: dataFilePath))")
//        do {
//            let encoder = PropertyListEncoder()
//            let data = try encoder.encode(self.itemArray)
//            try data.write(to: dataFilePath!)
//        } catch {
//            print("Error encoding item array")
//        }
//
//
//        //Refresh the tableView
//        self.tableView.reloadData()
//    }
    
    func saveItems() {
        // Solution 3: Core Data
        do {
            try self.context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        //Refresh the tableView
        self.tableView.reloadData()
    }
    
    
    //MARK: - Load items
    // "with request:" => Modify 'request' parameter with an external parameter
    // External parameter: with; Internal parameter: request
    // "= MyTodoeyItem.fetchRequest()" => Set a default value
    func loadItems(with request: NSFetchRequest<MyTodoeyItem> = MyTodoeyItem.fetchRequest()) {
        // Solution 1: UserDefault
        // Deprecated: we don't use UserDefaults in this case
        // Retrieve the array from the local storage (plist)
//        var items:[TodoeyItem] = []
//        guard let stringItems = defaults.array(forKey: "TodoListArray") as? [String] else {
//            print("'TodoListArray' not found in UserDefaults")
//            return
//        }
//
//        for (item) in stringItems {
//            items.append(TodoeyItem.toObject(todoeyItemString: item)!)
//        }
//        itemArray = items
        
        // Solution 2: FileManager
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([TodoeyItem].self, from: data)
//
//                //Refresh the tableView
//                self.tableView.reloadData()
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//        } else {
//            print("Error decoding item array")
//        }
        
        // Solution 3: Core Data
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
        // You can modify an operator using the key characters c and d within square braces to specify case and diacritic insensitivity respectively
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
        // Sort the data we get back in alphabetical order.
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
        //Refresh the tableView
        tableView.reloadData()
    }
    
    // This method will be triggered as "Enter" is typed
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        updateTableView(text: searchBar.text!)
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Reload all the data as users clear the Search Bar
        if searchBar.text?.count == 0 {
            loadItems()
            
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

