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
    
    let calculatorLogic = CalculatorLogic()
    private var isFinishedTypingNumber = true
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                return Double(calculatorLogic.DEFAULT_VALUE)
            }
            return number
        }
    }
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        
        if let calcValue = sender.currentTitle {
            switch (calcValue) {
            case "AC":
                reset()
                break
            case "+/-":
                displayLabel.text = doubleToString(calculatorLogic.convertToAnotherSign(displayValue))
                break
            case "%":
                displayLabel.text = doubleToString(calculatorLogic.convertToPercentage(displayValue))
                break
            case "=":
                if calculatorLogic.latestRecord == nil {
                    isFinishedTypingNumber = true
                    return
                }
                
                if calculatorLogic.OPERATORS.contains(calculatorLogic.latestRecord!) {
                    calculatorLogic.addNewRecord(String(displayValue))
                }
                
                guard let result = calculatorLogic.calculate() else {
                    fatalError("Error calculating")
                }
                displayLabel.text = String(doubleToString(result))
                break
            default:
                
                // Special case: ××
                if calcValue == "×" && calculatorLogic.latestRecord == "×" {
                    calculatorLogic.addNewRecord(String(displayValue))
                    return
                }
                
                if calcValue == calculatorLogic.latestRecord {
                    return
                }
                
                calculatorLogic.addNewRecord(String(displayValue))
                calculatorLogic.addNewRecord(calcValue)
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
                if displayLabel.text! == "\(calculatorLogic.DEFAULT_VALUE)" {
                    displayLabel.text = numValue
                } else {
                    displayLabel.text = displayLabel.text! + numValue
                }
            }
        }
    }
    
    private func doubleToString(_ value: Double) -> String {
        let isInteger = value.truncatingRemainder(dividingBy: 1) == 0 //value % 1 == 0
        return isInteger ? String(Int(value)) : String(value)
    }
    
    
    private func reset() {
        displayLabel.text = "\(calculatorLogic.DEFAULT_VALUE)"
        calculatorLogic.clearHistory()
    }
    

}

