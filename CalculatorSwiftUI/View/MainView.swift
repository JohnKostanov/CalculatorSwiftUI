//
//  MainView.swift
//  CalculatorSwiftUI
//
//  Created by Джон Костанов on 8/1/23.
//

import SwiftUI

struct MainView: View {
    
    @State var calculator = CalculatorActions()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(calculator.data.resultString)
                    .font(.system(size: 50))
            }
            .padding(.horizontal)
            HStack {
                ButtonView(label: .one, calculator: $calculator)
                ButtonView(label: .two, calculator: $calculator)
                ButtonView(label: .three, calculator: $calculator)
                ButtonView(label: .addition,
                           backgroundColor: Colors.orange,
                           calculator: $calculator)
            }
            .padding(.horizontal)
            HStack {
                ButtonView(label: .zero, calculator: $calculator)
                    .frame(width: calculator.getButtonWidth(.zero)
                           , height: calculator.getButtonHight())
                ButtonView(label: .comma, calculator: $calculator)
                    .frame(width: calculator.getButtonWidth(.equals)
                           , height: calculator.getButtonHight())
                ButtonView(label: .equals,
                           backgroundColor: Colors.orange,
                           calculator: $calculator)
                .frame(width: calculator.getButtonWidth(.equals)
                       , height: calculator.getButtonHight())
            }
            .padding(.horizontal)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
