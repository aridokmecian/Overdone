//
//  FloatingButtonView.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-09-28.
//

import SwiftUI

struct FloatingButtonView: View {
    
    var action: () -> Void
    
    var body: some View {
        withAnimation {
            HStack {
                VStack {
                    Spacer()
                    Button(action: self.action, label: {
                        ZStack {
                            Rectangle()
                                .cornerRadius(25)
                                .frame(width: 300, height: 60, alignment: .center)
                            Text("Click to Add New Entry")
                                .foregroundColor(.white)
                                .font(.subheadline)
                        }
                        .frame(width: 60, height: 60)
                    })
                }
            }
        }
    }
}

struct FloatingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButtonView(action: {print("hello world")})
    }
}
