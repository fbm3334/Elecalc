//
//  Settings.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 02/10/2020.
//

import Foundation

// Settings class
// Used to store user settings for the app.
class Settings: ObservableObject {
    // Variables
    @Published var hapticsOn: Bool = false
    @Published var decimalPlacesDouble: Double = 2.0
    @Published var decimalPlaces: Int = 2
    
    // Function to get the values from UserDefaults
    func getFromUserDefaults() {
        hapticsOn = UserDefaults.standard.bool(forKey: "HapticsOn")
        decimalPlaces = UserDefaults.standard.integer(forKey: "DecimalPlaces")
        decimalPlacesDouble = Double(decimalPlaces)
        print("Got haptic setting: \(hapticsOn) and decimal place setting: \(decimalPlaces)")
    }
    
    // Function to save the values to UserDefaults
    func saveToUserDefaults() {
        UserDefaults.standard.set(hapticsOn, forKey: "HapticsOn")
        decimalPlaces = Int(decimalPlacesDouble)
        UserDefaults.standard.set(decimalPlaces, forKey: "DecimalPlaces")
        print("Saved haptic setting: \(hapticsOn) and decimal place setting: \(decimalPlaces)")
    }

}
