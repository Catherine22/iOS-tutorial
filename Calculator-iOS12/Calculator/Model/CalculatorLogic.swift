//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Catherine Chen (RD-TW) on 12/02/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var history: [String] = []
    let OPERATORS = ["+", "-", "×", "÷"]
    let DEFAULT_VALUE = 0
    var latestRecord: String? {
        if history.count == 0 {
            return nil
        }
        return history[history.count - 1]
    }
    
    mutating func addNewRecord(_ value: String) {
        history.append(value)
    }
    
    mutating func clearHistory() {
        history.removeAll()
    }
    
    func convertToAnotherSign(_ value: Double) -> Double {
        return value * (-1)
    }
    
    func convertToPercentage(_ value: Double) -> Double {
        return value / 100
    }
    
    mutating func calculate() -> Double? {
        if OPERATORS.contains(history.last!) {
            history.removeLast()
        }
        
        print("calculating: \(history)")
        if varifyHistory() {
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
            return result
        }
        
        return nil
    }
    
    private func varifyHistory() -> Bool {
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
}
