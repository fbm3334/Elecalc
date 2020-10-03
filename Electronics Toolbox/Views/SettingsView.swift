//
//  SettingsView.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 01/10/2020.
//

import SwiftUI

// Function to get the device type, and return true if the device type is an iPhone. This is because iPads and iPod touches do not support haptic feedback, so there is no reason to show the control.
func isDeviceiPhone() -> Bool {
    let modelType = UIDevice.current.model
    if (modelType == "iPhone") {
        return true
    } else {
        return false
    }
}

struct SettingsView: View {
    
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        Form {
            // Do not show this section if device is not an iPhone
            if (isDeviceiPhone() == true) {
                Section(header: Text("Haptic feedback")) {
                    // Toggle haptic feedback
                    HStack {
                        Text("Haptic feedback")
                        Spacer()
                        Toggle("Haptic feedback", isOn: $settings.hapticsOn)
                            .labelsHidden()
                            .onTapGesture {
                                settings.hapticsOn = !settings.hapticsOn
                                print("Value set: \(settings.hapticsOn)")
                            }
                    }
                        
                    Text("You can turn on/off the haptic feedback (the small vibrations when using the app). The default iOS haptic feedback (for example when toggling the above toggle) cannot be disabled.")
                        .font(.caption)
                }
            }
            
            // Decimal places slider
            Section(header: Text("Decimal places")) {
                VStack {
                    HStack {
                        Text("Number of decimal places:")
                        Spacer()
                    }
                    HStack {
                        Slider(value: $settings.decimalPlacesDouble, in: 0...5, step: 1.0, onEditingChanged: {_ in 
                            settings.decimalPlaces = Int(settings.decimalPlacesDouble)
                        })
                        Text("\(settings.decimalPlacesDouble, specifier: "%.0f")")
                    }
                    
                }
            }
        }.navigationBarTitle(Text("Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
