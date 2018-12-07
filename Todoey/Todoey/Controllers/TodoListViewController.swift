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
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve the array from the local storage (plist)
        var items:[TodoeyItem] = []
        guard let stringItems = defaults.array(forKey: "TodoListArray") as? [String] else {
            print("'TodoListArray' not found in UserDefaults")
            return
        }
        
        for (item) in stringItems {
            items.append(TodoeyItem.toObject(todoeyItemString: item)!)
        }
        itemArray = items
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
        var flatArray: [String] = []
        for (item) in newDataSource {
            flatArray.append(item.toString()!)
        }
        self.defaults.set(flatArray, forKey: "TodoListArray")
        
        //Refresh the tableView
        self.tableView.reloadData()
    }
}

