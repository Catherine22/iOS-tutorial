//
//  ViewController.swift
//  Magic8Ball
//
//  Created by Catherine Chen on 24/09/2018.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var balls = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    
    @IBOutlet weak var ballImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createRandomAnswer()
    }
    
    @IBAction func onAskPressed(_ sender: Any) {
        createRandomAnswer()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        createRandomAnswer()
    }
    
    func createRandomAnswer() {
        let choseIndex: Int = Int.random(in: 0 ... 4)
        ballImageView.image = UIImage(named: balls[choseIndex])
    }
}

