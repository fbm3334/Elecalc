//
//  ContentView.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        CalculationList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func successHaptics() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

func errorHaptics() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}

func selectionHaptics() {
    let generator = UISelectionFeedbackGenerator()
    generator.selectionChanged()
}
