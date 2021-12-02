//
//  RegistrateView.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 12.11.2021.
//

import SwiftUI

struct RegistrateView: View {

    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text("Registrate")
                        .font(Font.system(size:50, design: .rounded))
                        .fontWeight(.heavy)
                        .textCase(.uppercase)
                    
                    Spacer();
                    TextField("", text: )
                        .placeholder(when: enterLogin.isEmpty, placeholder: {
                            Text("Login")
                        })
                        .padding(10)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
        .font(Font.system(size: 20, design: .rounded))
        .foregroundColor(.dark)
    }
}

struct RegistrateView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrateView()
    }
}
