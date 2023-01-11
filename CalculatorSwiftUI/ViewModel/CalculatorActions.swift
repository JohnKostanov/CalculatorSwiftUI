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
            actionNumber(button)
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
            actionAddition()
        case .equals:
            break
        }
    }
    
    private mutating func actionNumber(_ number: ActionButton.Labels) {
        guard data.resultString.count < 9 else { return }
        
        guard !data.setting.isActive else {
            data.resultString = number.rawValue
            data.setting.isActive = false
            return
        }
        
        if data.resultString.first == "0" {
            data.resultString = number.rawValue
        } else {
            data.resultString += number.rawValue
        }
        
    }
    
    private mutating func actionAddition() {
        if !data.setting.isActive {
            data.setting.isActive = true
            if data.setting.numberFirst == nil {
                data.setting.numberFirst = Int(data.resultString) ?? 0
            } else if data.setting.numberSecond == nil {
                data.setting.numberSecond = Int(data.resultString) ?? 0
                data.resultString = "\(data.setting.numberFirst! + data.setting.numberSecond!)"
                data.setting.numberSecond = Int(data.resultString)
            } else {
                data.resultString = "\(data.setting.numberSecond! + Int(data.resultString)!)"
                data.setting.numberSecond = Int(data.resultString)
            }
        }
    }
    
    func getButtonWidth(_ type: ActionButton.Labels = .equals) -> CGFloat {
        switch type {
        case .zero:
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        default:
            return ((UIScreen.main.bounds.width - (5 * 12)) / 4)
        }
        
    }
    
    func getButtonHight() -> CGFloat {
        (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}
