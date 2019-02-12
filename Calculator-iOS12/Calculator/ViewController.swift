//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber = true
    
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        if let calcValue = sender.currentTitle {
            switch (calcValue) {
            case "AC":
                reset()
                break
            case "+/-":
                if let displayValue = Double(displayLabel.text!) {
                    if displayValue > 0 {
                        displayLabel.text = "-" + displayLabel.text!
                    } else if displayValue < 0 {
                        displayLabel.text?.remove(at: displayLabel.text!.startIndex)
                    } else {
                        reset()
                    }
                }
                break
            case "%":
                if let displayValue = Double(displayLabel.text!) {
                    let percentage = displayValue / 100
                    let isInteger = percentage.truncatingRemainder(dividingBy: 1) == 0 //percentage % 1 == 0
                    displayLabel.text = isInteger ? String(Int(percentage)) : String(percentage)
                }
                break
            default:
                break
            }
        }
        
        isFinishedTypingNumber = true
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                if numValue == "." {
                    displayLabel.text = displayLabel.text! + numValue
                } else {
                    displayLabel.text = numValue
                }
                isFinishedTypingNumber = false
            } else {
                if displayLabel.text! == "0" {
                    displayLabel.text = numValue
                } else {
                    displayLabel.text = displayLabel.text! + numValue
                }
            }
        }
    }
    
    
    func reset () {
        displayLabel.text = "0"
    }

}

