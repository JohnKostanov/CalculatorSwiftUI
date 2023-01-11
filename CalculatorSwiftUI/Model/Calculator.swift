//
//  Calculator.swift
//  CalculatorSwiftUI
//
//  Created by Джон Костанов on 9/1/23.
//

import Foundation

struct Calculator: Calculatable {
    var resultString = "0"
    var setting: ActionButton
}


struct ActionButton {
    enum Labels: String {
        case comma = ",", zero = "0", one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9"
        case ac = "AC", plusMinus = "±", percent = "%", division = "÷", multiplication = "×", subtraction = "−", addition = "+", equals = "="
    }
    
    var label: Labels
    var numberFirst: Int?
    var numberSecond: Int?
    var isActive = false
}


