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
            actionComma()
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
        data.resultString = ActionButton.Labels.zero.rawValue
        data.setting.statusAC = true
    }
    
    private mutating func actionPercent() {
        let percent = (prepareStringForAction(data.resultString) / 100)
        if data.numberFirst == nil {
            data.numberFirst = percent
            data.resultString = "\(percent)"
        } else if data.numberSecond == nil {
            data.resultString = "\(data.numberFirst! * percent)"
            data.numberSecond = prepareStringForAction(data.resultString)
        } else {
            data.resultString = "\(percent)"
        }
    }
    
    private mutating func actionPlusMinus() {
        data.resultString = "\(prepareStringForAction(data.resultString) * -1)"
    }
    
    private mutating func actionNumber(_ number: ActionButton.Labels) {
        data.setting.statusAC = false
        data.setting.isTyping = true
        
        guard !data.setting.isActive else {
            data.resultString = number.rawValue
            data.setting.isActive = false
            return
        }
        guard data.resultString.count <= 9 else { return }
        
        if data.resultString == ActionButton.Labels.zero.rawValue {
            data.resultString = number.rawValue
            data.setting.isTyping = false
        }
        
        if data.setting.isTyping {
            data.resultString += number.rawValue
        }
    }
    
    private mutating func actionComma() {
        data.setting.statusAC = false
        
        guard !data.setting.isActive else {
            data.resultString = ActionButton.Labels.zero.rawValue
            data.resultString += ActionButton.Labels.comma.rawValue
            data.setting.isActive = false
            return
        }
        guard data.resultString.count <= 9 else { return }
        
        if !data.resultString.contains(ActionButton.Labels.comma.rawValue) {
            data.resultString += ActionButton.Labels.comma.rawValue
        }
    }
    
    private mutating func action(with operation: ActionButton.Labels, by action: (Double, Double) -> String) {
        data.setting.currentOperation = operation
        data.setting.isTyping = false
        if !data.setting.isActive {
            if data.numberFirst == nil {
                data.numberFirst = prepareStringForAction(data.resultString)
            } else if data.numberSecond == nil {
                data.numberSecond = prepareStringForAction(data.resultString)
                data.resultString =  action(data.numberFirst!, data.numberSecond!)
                data.numberSecond = prepareStringForAction(data.resultString)
            } else {
                data.numberFirst =  prepareStringForAction(data.resultString)
                data.resultString = action(data.numberSecond!, data.numberFirst!)
                data.numberFirst = prepareStringForAction(data.resultString)
                data.numberSecond = nil
            }
        }
        data.setting.isActive = true
    }
    
    private mutating func actionEquals() {
        func getResults(by action: (Double, Double) -> String) {
            if data.numberFirst == nil {
                data.numberFirst = prepareStringForAction(data.resultString)
            } else if data.numberSecond == nil {
                data.numberSecond = prepareStringForAction(data.resultString)
                data.resultString = action(data.numberFirst!, data.numberSecond!)
            } else {
                data.resultString =  action(prepareStringForAction(data.resultString), data.numberSecond!)
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
        data.setting.isActive = true
        data.setting.isTyping = false
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
    
    private func prepareStringForAction(_ string: String) -> Double {
        let formattedString = string.map { character in
            if character.description == ActionButton.Labels.comma.rawValue {
               return "."
            }
            return character.description
        }.reduce("", +)
        assert(Double(formattedString) != nil, "Ошибка преобразования строки в число типа Double в:\(#line), \(#function)")
        let doubleNumber = Double(formattedString) ?? 0.0
        return doubleNumber
    }
}
