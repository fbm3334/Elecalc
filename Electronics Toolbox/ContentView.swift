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
    // Check if haptic feedback has been disabled - if true, then play the haptic
    if (UserDefaults.standard.bool(forKey: "HapticsOn") == true) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

func errorHaptics() {
    // Check if haptic feedback has been disabled - if true, then play the haptic
    if (UserDefaults.standard.bool(forKey: "HapticsOn") == true) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

func selectionHaptics() {
    // Check if haptic feedback has been disabled - if true, then play the haptic
    if (UserDefaults.standard.bool(forKey: "HapticsOn") == true) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
