//
//  CategorySheetFloatingPanel.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 31/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

protocol CategorySheetSelection {
    func onCategorySelected(category: Category)
}

class CategorySheetFloatingPanel: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var categoryTableView: UITableView!
    
    var realm: Realm? = nil
    var categories: Results<Category>?
    var categorySheetSelection: CategorySheetSelection?
    
    
    let BY_KEY_PATH = "name"
    let ASCENDING = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    // TODO: TableView - Set up each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryLabel.text = categories?[indexPath.row].name
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].backgroundColorHex ?? "FFFFFF")
        return cell
    }

    // TODO: TableView - Set up the amount of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    // TODO: TableView - Click event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categorySheetSelection?.onCategorySelected(category: (categories?[indexPath.row])!)
//        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Realm - Data Manipulation Methods
    func loadCategories() {
        categories = realm?.objects(Category.self)
        categoryTableView.reloadData()
    }

}

extension CategorySheetFloatingPanel: UISearchBarDelegate {
    
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
        } else {
            // Query data as users are typing to improve user experience.
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
            queryItems(predicate: predicate, byKeyPath: BY_KEY_PATH, ascending: ASCENDING)
        }
    }
    
    // MARK: Realm - Data Manipulation Methods
    func loadItems() {
        categories = realm?.objects(Category.self).sorted(byKeyPath: BY_KEY_PATH, ascending: ASCENDING)
        categoryTableView.reloadData()
    }
    
    // MARK: Realm - Data Manipulation Methods
    func queryItems(predicate: NSPredicate, byKeyPath: String, ascending: Bool) {
        categories = categories?.filter(predicate).sorted(byKeyPath: byKeyPath, ascending: ascending)
        categoryTableView.reloadData()
    }
}
