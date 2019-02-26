//
//  ViewController.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let githubModule = GithubModule()
        githubModule.getAlamofireRepo(onSuccess: {
            self.popUpResponseAlert(message: "Succeed!")
        },onFail: { (error) in
            self.popUpResponseAlert(message: "\(error)")
        })
    }
    
    func popUpResponseAlert(message: String) {
        let alert = UIAlertController(title: "Response", message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            
        }
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
}

