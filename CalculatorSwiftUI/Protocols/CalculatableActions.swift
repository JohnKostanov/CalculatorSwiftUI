//
//  CalculatableActions.swift
//  CalculatorSwiftUI
//
//  Created by Джон Костанов on 9/1/23.
//

import Foundation

protocol CalculatableActions {
    var data: Calculator { get }
    
    func calculateAction(button: ActionButton)
}
