//
//  AboutView.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 16/09/2020.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Form {
            VStack {
                Image("1024px rounded noBG")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                    .multilineTextAlignment(.center)
                Text("Elecalc")
                    .font(.title)
                    .fontWeight(.bold)
                Text("by Finn Beckitt-Marshall")
                    .font(.caption)
            }
            .multilineTextAlignment(.center)
        }
    .navigationBarTitle(String("About this app"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
