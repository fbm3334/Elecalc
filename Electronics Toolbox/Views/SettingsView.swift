//
//  SettingsView.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 01/10/2020.
//

import SwiftUI

struct SettingsView: View {
    
    @State var hapticsOn: Bool = UserDefaults.standard.bool(forKey: "HapticsOn")
    
    var body: some View {
        Form {
            Section(header: Text("Haptic feedback")) {
                // Toggle haptic feedback
                Toggle("Haptic feedback", isOn: $hapticsOn)
                    .labelsHidden()
                    .onTapGesture {
                        hapticsOn = !hapticsOn
                        print("Value set: \(hapticsOn)")
                        UserDefaults.standard.set(hapticsOn, forKey: "HapticsOn")
                        // Print the value saved to UserDefaults for verification
                        print("Value saved to UserDefaults: \(UserDefaults.standard.bool(forKey: "HapticsOn"))")
                    }
                    
                    
                Text("You can turn on/off the haptic feedback (the small vibrations when using the app).")
                    .font(.caption)
            }
        }.navigationBarTitle(Text("Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
