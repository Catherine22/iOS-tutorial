//
//  ItemViewController.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 29/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import RealmSwift
import FloatingPanel

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CategorySheetSelection {
    
    @IBOutlet weak var itemTableView: UITableView!
    var controller: UIViewController?
    var searchController : UISearchController!
    var floatingPanelController: FloatingPanelController!
    
    var realm: Realm? = nil
    var items: Results<Item>?
    var queryAll: Bool?
    var selectedCategory: Category?
    
    // sorting rules
    let BY_KEY_PATH = "dateCreated"
    let ASCENDING = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        itemTableView.rowHeight = 80.0
        itemTableView.separatorStyle = .none
        
        navigationItem.title = (queryAll ?? false) ? "ALL" : selectedCategory?.name
        
        // MARK: Realm - initialising
        do {
            realm = try Realm()
            loadItems()
        } catch {
            NSLog("Error Initialising Realm: \(error)")
        }
        
        // Set searchBar inside NavigationController
        initUISearchController()
    }
    
    
    // This method will be called when viewDidLoad() has run
    override func viewWillAppear(_ animated: Bool) {
        let color = (queryAll ?? false) ? UIColor.white : UIColor(hexString: selectedCategory?.backgroundColorHex ?? UIColor.white.hexValue())
        let contrastingColor = UIColor(contrastingBlackOrWhiteColorOn: color!, isFlat: true)
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist")
        }
        navBar.prefersLargeTitles = true
        navBar.barTintColor = color
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: contrastingColor]
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: contrastingColor]
        navBar.tintColor = contrastingColor
    }
    
    // TODO: TableView - Set up each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let backgroundColor = getBackgroundColor(index: indexPath.row)
        cell.itemLabel.text = items?[indexPath.row].name
        cell.backgroundColor = backgroundColor
        cell.itemLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: backgroundColor, isFlat: true)
        return cell
    }
    
    // TODO: TableView - Set up the amount of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    // TODO: TableView - Click event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // TODO: TableView - Swipe to remove cells
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // TODO: TableView - Swipe to remove cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(item: items![indexPath.row], at: indexPath.row)
            itemTableView.beginUpdates()
            itemTableView.deleteRows(at: [indexPath], with: .fade)
            itemTableView.endUpdates()
        }
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        if queryAll ?? false {
            popOverCategorySheet()
        } else {
            createNewItem()
        }
    }
    
    func getBackgroundColor(index: Int) -> UIColor {
        let defaultColor = UIColor.white
        if queryAll ?? false {
            if let item = items?[index] {
                let predicate = NSPredicate(format: "name == %@", item.parentCategoryName)
                let parentCategory = realm?.objects(Category.self).filter(predicate).first
                if let solidColor = parentCategory?.backgroundColorHex {
                    let gradient = CGFloat(index) / CGFloat(items?.count ?? 0)
                    return UIColor(hexString: solidColor)?.darken(byPercentage: gradient) ?? defaultColor
                }
            }
        } else {
            if let solidColor = selectedCategory?.backgroundColorHex {
                let gradient = CGFloat(index + 1) / CGFloat(items?.count ?? 0)
                return UIColor(hexString: solidColor)?.darken(byPercentage: gradient) ?? defaultColor
            }
        }
        return defaultColor
    }
    
    
    // TODO: Retrieve data from the second ViewController via protocal
    func onCategorySelected(category: Category) {
        floatingPanelController.removePanelFromParent(animated: true)
        selectedCategory = category
        createNewItem()
    }
    
    func createNewItem() {
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        //Create a UITextField and set it to equal to the alertTextField
        var itemTextField = UITextField()
        let writeAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(writeAction)
        alert.addAction(cancelAction)
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
                item.dateCreated = Date()
                item.parentCategoryName = (selectedCategory?.name)!
                selectedCategory?.items.append(item)
            }
            
            // Refresh the tableView
            itemTableView.reloadData()
        } catch {
            NSLog("Error writing Realm: \(error)")
        }
    }
    
    // MARK: Realm - DataManipulation Methods
    func deleteItem(item: Item, at index: Int) {
        do {
            try realm?.write {
                realm?.delete(item)
            }
        } catch {
            NSLog("Error writing Realm: \(error)")
        }
    }
    
    // MARK: Realm - Data Manipulation Methods
    func loadItems() {
        if queryAll ?? false {
            items = realm?.objects(Item.self).sorted(byKeyPath: BY_KEY_PATH, ascending: ASCENDING)
        } else {
            let predicate = NSPredicate(format: "name == %@", selectedCategory!.name)
            let category = realm?.objects(Category.self).filter(predicate).first
            items = category?.items.sorted(byKeyPath: BY_KEY_PATH, ascending: ASCENDING)
        }
        itemTableView.reloadData()
    }
    
    // MARK: Realm - Data Manipulation Methods
    func queryItems(predicate: NSPredicate, byKeyPath: String, ascending: Bool) {
        items = items?.filter(predicate).sorted(byKeyPath: byKeyPath, ascending: ascending)
        itemTableView.reloadData()
    }

}

extension ItemViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    // This method will be triggered as "Enter" is typed
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        updateTableView(text: searchBar.text!)
    //    }
    
    func initUISearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = true
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
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
}

extension ItemViewController: FloatingPanelControllerDelegate {
    func popOverCategorySheet() {
        // Initialize a `FloatingPanelController` object.
        floatingPanelController = FloatingPanelController()
        
        // Assign self as the delegate of the controller.
        floatingPanelController.delegate = self // Optional
        
        // Set a content view controller.
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "CategorySheet") as! CategorySheetFloatingPanel
        contentVC.categorySheetSelection = self
        floatingPanelController.set(contentViewController: contentVC)
        
        // Track a scroll view(or the siblings) in the content view controller.
        floatingPanelController.track(scrollView: contentVC.categoryTableView)
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        floatingPanelController.addPanel(toParent: self)
    }
}
