//
//  ViewController.swift
//  Delegates and Protocols
//
//  Created by Catherine Chen on 25/10/2018.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CanReceive {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func sendButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendDataForwards", sender: self)
    }
    @IBAction func changeToBlue(_ sender: Any) {
        view.backgroundColor = UIColor.blue
    }
    
    func dataReceived(data: String) {
        label.text = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendDataForwards" {
            
            // We are not allowed to create a ViewController Object regularly, like
            // let secondVC = SecondViewController()
            // Instead, we do
            let secondVC = segue.destination as! SecondViewController
            secondVC.data = textField.text!
        }
    }

}

