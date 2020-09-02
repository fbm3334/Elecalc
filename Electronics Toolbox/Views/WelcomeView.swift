//
//  WelcomeView.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 02/09/2020.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to Electronics Toolbox!")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text("Please use the left sidebar to select a calculation.")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
