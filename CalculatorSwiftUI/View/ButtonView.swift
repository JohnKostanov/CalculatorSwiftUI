//
//  ButtonView.swift
//  CalculatorSwiftUI
//
//  Created by Джон Костанов on 8/1/23.
//

import SwiftUI

struct ButtonView: View {
    var label: ActionButton.Labels
    var backgroundColor = Colors.darkGray
    @Binding var calculator: CalculatorActions
    
    var body: some View {
        Button {
            calculator.calculateAction(button: label)
        } label: {
            ZStack {
                Circle().foregroundColor(backgroundColor)
                Text(label.rawValue)
                    .foregroundColor(.white)
                    .font(Font.system(size: 50,
                                      design: Font.Design.rounded))
            }
        }

    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
       MainView()
    }
}
