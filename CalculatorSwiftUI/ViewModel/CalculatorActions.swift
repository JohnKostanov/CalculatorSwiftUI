//
//  CalculatorActions.swift
//  CalculatorSwiftUI
//
//  Created by Джон Костанов on 9/1/23.
//

import SwiftUI

struct CalculatorActions: CalculatableActions {
    var data = Calculator(setting: ActionButton(label: .zero))
    
    mutating func calculateAction(button: ActionButton.Labels) {
        switch button {
        case .comma:
            break
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            data.resultString += button.rawValue
        case .ac:
            break
        case .plusMinus:
            break
        case .percent:
            break
        case .division:
            break
        case .multiplication:
            break
        case .subtraction:
            break
        case .addition:
            break
        case .equals:
            break
        }
    }
}
