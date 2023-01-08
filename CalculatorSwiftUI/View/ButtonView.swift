//
//  ButtonView.swift
//  CalculatorSwiftUI
//
//  Created by Джон Костанов on 8/1/23.
//

import SwiftUI

struct ButtonView: View {
    var label = "0"
    var backgroundColor = Color.gray
    var action: (String) -> Void
    
    var body: some View {
        Button {
            action(label)
        } label: {
            ZStack {
                Circle().foregroundColor(backgroundColor)
                Text(label)
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
