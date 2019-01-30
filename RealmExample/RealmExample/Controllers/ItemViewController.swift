//
//  ItemViewController.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 29/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import RealmSwift

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var realm: Realm? = nil
    var items: List<Item>?
    var queryAll: Bool?
    var selectedCategory: Category?

    override func viewDidLoad() {
        super.viewDidLoad()

        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        
        // MARK: Realm - initialising
        do {
            realm = try Realm()
            loadItems()
        } catch {
            NSLog("Error Initialising Realm: \(error)")
        }
    }
    
    // TODO: TableView - Set up each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
       cell.itemLabel.text = items?[indexPath.row].name
        return cell
    }
    
    // TODO: TableView - Set up the amount of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    // TODO: TableView - Click event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var itemTextField = UITextField()
        let writeAction = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            if let itemName = itemTextField.text {
                var skipSaving = false
                self.items?.forEach({ (item) in
                    if itemName == item.name {
                        skipSaving = true
                        return
                    }
                })
                
                if skipSaving {
                    self.popUpAlert(title: "Warning", message: "Item existed", completion: nil)
                } else {
                    // Persistant data via Realm
                    self.save(itemName: itemName)
                }
            } else {
                self.popUpAlert(title: "Warning", message: "Please fill in a item", completion: nil)
            }
        }
        
        alert.addAction(writeAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            itemTextField = alertTextField
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
    func save(itemName: String) {
        do {
            try realm?.write {
                let item = Item()
                item.name = itemName
                selectedCategory?.items.append(item)
            }
            
            // Refresh the tableView
            itemTableView.reloadData()
        } catch {
            NSLog("Error writing Realm: \(error)")
        }
    }
    
    func loadItems() {
//        // MARK: Realm - Data Manipulation Methods
        if queryAll ?? false {
            let categories = realm?.objects(Category.self)
            categories?.forEach({ (category) in
                category.items.forEach({ (item) in
                    items?.append(item)
                })
            })
        } else {
            let category = realm?.objects(Category.self).filter("name == %@", selectedCategory?.name).first
            items = category?.items
        }
        itemTableView.reloadData()
    }

}
