//
//  MainView.swift
//  CalculatorSwiftUI
//
//  Created by Джон Костанов on 8/1/23.
//

import SwiftUI

struct MainView: View {
    @State var result = "0"
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(result)
                    .font(.system(size: 50))
            }
            .padding()
            HStack {
                ButtonView(label: "1") {
                    result += $0
                }
                ButtonView(label: "2") {
                    result += $0
                }
                ButtonView(label: "3") {
                    result += $0
                }
                ButtonView(label: "+") {
                    result += $0
                }
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
