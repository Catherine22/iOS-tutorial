//
//  SecondViewController.swift
//  Segues
//
//  Created by Catherine Chen on 24/10/2018.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var textPassedOver: String?
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = textPassedOver
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
