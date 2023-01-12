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
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(calculator.data.resultString)
                        .font(.system(size: 100))
                }
                .padding()
            }
            
            ForEach(calculator.data.allButtons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        ButtonView(label: button, calculator: $calculator)
                            .frame(width: calculator.getButtonWidth(button),
                                   height: calculator.getButtonHight())
                    }
                }
                .padding(.bottom, 3)
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
