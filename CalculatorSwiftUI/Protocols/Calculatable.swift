//
//  Calculatable.swift
//  CalculatorSwiftUI
//
//  Created by Джон Костанов on 9/1/23.
//

import Foundation

protocol Calculatable {
    var resultString: String { get }
    var setting: ActionButton { get }
}
