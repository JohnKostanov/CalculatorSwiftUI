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
            actionAC()
        case .plusMinus:
            actionPlusMinus()
        case .percent:
            actionPercent()
        case .division:
            action(with: button) { "\($0 / $1)" }
        case .multiplication:
            action(with: button) { "\($0 * $1)" }
        case .subtraction:
            action(with: button) { "\($0 - $1)" }
        case .addition:
            action(with: button) { "\($0 + $1)" }
        case .equals:
            actionEquals()
        }
    }
    
    // MARK: - Actions methods
    private mutating func actionAC() {
        if data.setting.statusAC {
            data.numberFirst = nil
            data.numberSecond = nil
        }
        data.resultString = "0"
        data.setting.statusAC = true
    }
    
    private mutating func actionPercent() {
        if data.numberFirst == nil {
            let resultString = Double(data.resultString) ?? 0.0
            let percent = (resultString / 100)
            data.numberFirst = percent
            data.resultString = "\(percent)"
        } else if data.numberSecond == nil {
            let resultString = Double(data.resultString) ?? 0.0
            let percent = (resultString / 100)
            data.resultString = "\(data.numberFirst! * percent)"
            data.numberSecond = Double(data.resultString)
        } else {
            let resultString = Double(data.resultString) ?? 0.0
            let percent = (resultString / 100)
            data.resultString = "\(percent)"
        }
    }
    
    private mutating func actionPlusMinus() {
        data.resultString = "\(Double(data.resultString)! * -1)"
    }
    
    private mutating func actionNumber(_ number: ActionButton.Labels) {
        data.setting.statusAC = false
        
        guard !data.setting.isActive else {
            data.resultString = number.rawValue
            data.setting.isActive = false
            return
        }
        guard data.resultString.count <= 9 else { return }
        
        
        if data.resultString.first == "0" {
            data.resultString = number.rawValue
        } else {
            data.resultString += number.rawValue
        }
    }
    
    private mutating func action(with operation: ActionButton.Labels, by action: (Double, Double) -> String) {
        data.setting.currentOperation = operation
        if !data.setting.isActive {
            data.setting.isActive = true
            if data.numberFirst == nil {
                data.numberFirst = Double(data.resultString) ?? 0.0
            } else if data.numberSecond == nil {
                data.numberSecond = Double(data.resultString) ?? 0.0
                data.resultString =  action(Double(data.numberFirst!), Double(data.numberSecond!))
                data.numberSecond = Double(data.resultString)
            } else {
                data.numberFirst = Double(data.resultString)
                data.numberSecond = nil
            }
        }
    }
    
    private mutating func actionEquals() {
        func getResults(by action: (Double, Double) -> String) {
            if data.numberFirst == nil {
                data.numberFirst = Double(data.resultString) ?? 0.0
            } else if data.numberSecond == nil {
                data.numberSecond = Double(data.resultString) ?? 0.0
                data.resultString = action(Double(data.numberFirst!), Double(data.numberSecond!))
            } else {
                data.resultString =  action(Double(data.resultString)!, Double(data.numberSecond!))
            }
        }
        switch data.setting.currentOperation {
        case .division:
            getResults { "\($0 / $1)" }
        case .multiplication:
            getResults { "\($0 * $1)" }
        case .subtraction:
            getResults { "\($0 - $1)" }
        case .addition:
            getResults { "\($0 + $1)" }
        default:
            break
        }
        data.setting.isActive = false
    }
    
    // MARK: - Setting methods
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
    
    func setLabels(_ button: ActionButton.Labels) -> String {
        if button == ActionButton.Labels.ac {
            if data.resultString == "0" || data.setting.statusAC {
                return "AC"
            } else {
                return "C"
            }
        } else {
            return button.rawValue
        }
    }
}
