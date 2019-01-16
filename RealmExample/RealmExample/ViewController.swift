//
//  ViewController.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 16/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var realm: Realm? = nil
    @IBOutlet weak var logLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // MARK: Realm - initialising
        do {
            realm = try Realm()
        } catch {
            NSLog("Error Initialising Realm: \(error)")
        }
    }

    @IBAction func onReadButtonPressed(_ sender: Any) {
    }
    
    @IBAction func onDeleteButtonPressed(_ sender: Any) {
    }
    
    @IBAction func onUpdateButtonPressed(_ sender: Any) {
    }
    
    @IBAction func onWriteButtonPressed(_ sender: Any) {
        if !(nameTextField.text ?? "").isEmpty && !(ageTextField.text ?? "").isEmpty {
            if !String.isInt(ageTextField.text!) || Int(ageTextField.text!)! < 1 {
                popUpAlert(title: "Warning", message: "Please type a reasonable age", completion: {
                    self.ageTextField.text = ""
                })
                return
            }
            
            // MARK: Realm - Write
            do {
                try realm?.write {
                    let dataModel = DataModel()
                    dataModel.name = nameTextField.text!
                    dataModel.age = Int(ageTextField.text!)!
                }
            } catch {
                NSLog("Error writting Realm: \(error)")
            }
        } else {
            popUpAlert(title: "Warning", message: "Please fill in the blanks", completion: nil)
        }
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
    
}

extension String {
    static func isInt(_ string: String) -> Bool {
        return Int(string) != nil
    }
}
