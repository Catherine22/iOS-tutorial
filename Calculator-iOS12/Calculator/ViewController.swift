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
    
    let OPERATORS = ["+", "-", "×", "÷"]
    private var isFinishedTypingNumber = true
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                return 0
            }
            return number
        }
    }
    private var history: [String] = []
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        
        if let calcValue = sender.currentTitle {
            switch (calcValue) {
            case "AC":
                reset()
                break
            case "+/-":
                if displayValue > 0 {
                    displayLabel.text = "-" + displayLabel.text!
                } else if displayValue < 0 {
                    displayLabel.text?.remove(at: displayLabel.text!.startIndex)
                } else {
                    displayLabel.text = "0"
                }
                history.append(String(displayValue))
                break
            case "%":
                let percentage = displayValue / 100
                displayLabel.text = doubleToString(percentage)
                history.append(String(displayValue))
                break
            case "=":
                if history.last != nil && OPERATORS.contains(history.last!) {
                    history.append(String(displayValue))
                }
                calculate()
                break
            default:
                
                // Special case: ××
                if calcValue == "×" && history.last == "×" {
                    history.append(String(displayValue))
                    return
                }
                
                if calcValue == history.last {
                    return
                }
                
                history.append(String(displayValue))
                history.append(calcValue)
                print(history)
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
    
    func calculate() {
        if OPERATORS.contains(history.last!) {
            history.removeLast()
        }
        print(history)
        if varifyHistory() {
            print("varified")
            var temp: [String] = []
            
            // order of operations: Multiply and Divide first
            var skipAppending = false
            for (index, element) in history.enumerated() {
                if "×" == element {
                    temp.removeLast()
                    let result = Double(history[index - 1])! * Double(history[index + 1])!
                    temp.append(String(result))
                    skipAppending = true
                } else if "÷" == element {
                    temp.removeLast()
                    let result = Double(history[index - 1])! / Double(history[index + 1])!
                    temp.append(String(result))
                    skipAppending = true
                } else {
                    if !skipAppending {
                        temp.append(element)
                    }
                    skipAppending = false
                }
            }
            
            print(temp)
            var result = Double(temp[0])!
            var prev = result
            // order of operations: Add and Subtract
            for (index, element) in temp.enumerated() {
                if "+" == element {
                    result = prev + Double(temp[index + 1])!
                } else if "-" == element {
                    result = prev - Double(temp[index + 1])!
                }
                prev = result
            }
            
            history.removeAll()
            displayLabel.text = String(doubleToString(result))
        }
    }
    
    func varifyHistory() -> Bool {
        var isValid = true
        for (index, element) in history.enumerated() {
            // Must be num1 [+-×÷] num2 [+-×÷] num3 ...
            if index != history.count - 1 && OPERATORS.contains(element) {
                if Double(history[index - 1]) == nil || Double(history[index + 1]) == nil {
                    isValid = false
                }
            }
        }
        return isValid
    }
    
    func doubleToString(_ value: Double) -> String {
        let isInteger = value.truncatingRemainder(dividingBy: 1) == 0 //value % 1 == 0
        return isInteger ? String(Int(value)) : String(value)
    }
    
    
    func reset() {
        displayLabel.text = "0"
        history.removeAll()
    }
    

}

