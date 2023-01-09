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
            .padding()
            HStack {
                ButtonView(label: .one, calculator: $calculator)
                ButtonView(label: .two, calculator: $calculator)
                ButtonView(label: .three, calculator: $calculator)
                ButtonView(label: .addition,
                           backgroundColor: Colors.orange,
                           calculator: $calculator)
            }
            .padding()
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
