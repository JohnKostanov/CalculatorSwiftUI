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
            if data.numberFirst == nil {
                data.numberFirst = Int(data.resultString) ?? 0
            } else if data.numberSecond == nil {
                data.numberSecond = Int(data.resultString) ?? 0
                data.resultString = "\(data.numberFirst! + data.numberSecond!)"
                data.numberSecond = Int(data.resultString)
            } else {
                data.resultString = "\(data.numberSecond! + Int(data.resultString)!)"
                data.numberSecond = Int(data.resultString)
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
    
    func getButtonColor(_ type: ActionButton.Labels) -> Color {
        switch type {
        case .comma, .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Colors.darkGray
        case .ac, .plusMinus, .percent:
            return Colors.lightGray
        case .division, .multiplication, .subtraction, .addition, .equals:
            return Colors.orange
        }
    }
    
    
}
