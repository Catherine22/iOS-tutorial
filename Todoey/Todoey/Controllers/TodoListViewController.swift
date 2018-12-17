//
//  ViewController.swift
//  Todoey
//
//  Created by Catherine Chen on 22/11/2018.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray:[TodoeyItem] = []
    // Deprecated: we don't use UserDefaults in this case
//    let defaults = UserDefaults.standard
    
    // Instead of using the default plist, we're going to create our own plist.
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        print("Saved item array in \(String(describing: dataFilePath))")
        loadItems()
    }

    
    //MARK - TableView Datasource Methods
    
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
        
        //To trigger the top tableView delegate method again once we change the item's done property
        tableView.reloadData()
        persistentData(newDataSource: itemArray)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add new Todoey Item", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var textField = UITextField()
        let writeAction = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            print("clicked")
            
            if let content = textField.text {
                self.itemArray.append(TodoeyItem(title: content, done: false))
                self.persistentData(newDataSource: self.itemArray)
            }
        }
        
        alert.addAction(writeAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Persistent the array
    func persistentData(newDataSource: [TodoeyItem]) {
        // Deprecated: we don't use UserDefaults in this case
//        var flatArray: [String] = []
//        for (item) in newDataSource {
//            flatArray.append(item.toString()!)
//        }
//
//        self.defaults.set(flatArray, forKey: "TodoListArray")
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(self.itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array")
        }
        
        //Refresh the tableView
        self.tableView.reloadData()
    }
    
    //MARK - Load items
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([TodoeyItem].self, from: data)
                
                //Refresh the tableView
                self.tableView.reloadData()
            } catch {
                print("Error decoding item array, \(error)")
            }
        } else {
            print("Error decoding item array")
        }
    }
}

