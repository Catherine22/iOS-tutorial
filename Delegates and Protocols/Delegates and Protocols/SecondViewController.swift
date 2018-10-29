//
//  SecondViewController.swift
//  Delegates and Protocols
//
//  Created by Catherine Chen on 29/10/2018.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit

protocol CanReceive {
    func dataReceived(data: String)
}

class SecondViewController: UIViewController {
    var data = "Default Label"
    var dalegate: CanReceive?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func backButtonPressed(_ sender: Any) {
        dalegate?.dataReceived(data: label.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = data
    }

}
