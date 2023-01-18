//
//  ButtonView.swift
//  CalculatorSwiftUI
//
//  Created by Джон Костанов on 8/1/23.
//

import SwiftUI

struct ButtonView: View {
    var label: ActionButton.Labels
    @Binding var calculator: CalculatorActions
    
    var body: some View {
        Button {
            calculator.calculateAction(button: label)
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(calculator.getButtonColor(label))
                    .cornerRadius(calculator.getButtonWidth())
                Text(calculator.setLabels(label))
                    .foregroundColor(calculator.getButtonColorForLabel(label))
                    .font(.system(size: 40))
            }
        }

    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
       MainView()
    }
}
