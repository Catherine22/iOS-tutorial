//
//  ViewController.swift
//  Dicee
//
//  Created by Catherine Chen on 23/09/2018.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var diceeLogoView: UIImageView!
    @IBOutlet weak var rollView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Resize
        let horizontalCenter = self.view.frame.width/2
        let sectionHeight = self.view.frame.height/4
        diceeLogoView.center = CGPoint(x: horizontalCenter, y: sectionHeight)
        diceImageView1.center = CGPoint(x: horizontalCenter/2, y: sectionHeight*2)
        diceImageView2.center = CGPoint(x: horizontalCenter*3/2, y: sectionHeight*2)
        rollView.center = CGPoint(x: horizontalCenter, y: sectionHeight*3.5)
        
        updateDiceImages()
    }
    
    @IBAction func rollButtonPressed(_ sender: Any) {
        // This will get executed when the roll button gets pressed.
        updateDiceImages()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
    
    
    func updateDiceImages() {
        randomDiceIndex1 = Int.random(in: 0 ... 5) // 0 ≤ r ≤ 5
        randomDiceIndex2 = Int.random(in: 0 ... 5)
        
        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
    }
}

