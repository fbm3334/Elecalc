//
//  ThermalResistanceCalculator.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 07/09/2020.
//

import SwiftUI


struct ThermalResistanceCalculator: View {
    
    var doubleFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 5
        return formatter
    }()
    
    @EnvironmentObject var thermalCalcs: ThermalCalcs
    @EnvironmentObject var settings: Settings
    
    @ViewBuilder
    var body: some View {
        Form {
            // Temperature entry
            Section(header: Text("Temperatures")) {
                // HStack to store value rows
                HStack {
                    Text("Ambient (ºC)")
                    Spacer()
                    TextField("Temperature", text: $thermalCalcs.ambientTemperatureString)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Max temperature (ºC)")
                    Spacer()
                    TextField("Temperature", text: $thermalCalcs.maxAllowableTemperatureString)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            // Power dissipated
            Section(header: Text("Power dissipation")) {
                HStack {
                    Text("Device power dissipated (W)")
                    Spacer()
                    TextField("Power", text: $thermalCalcs.powerDissipatedString)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
            }
                
            // Thermal resistance values (junction to case and junction to ambient)
            Section(header: Text("Thermal resistances")) {
                HStack {
                    Text("Junction to case (ºC/W)")
                    Spacer()
                    TextField("Thermal resistance", text: $thermalCalcs.thermalResistanceJuncToCaseString)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Junction to ambient (ºC/W)")
                    Spacer()
                    TextField("Thermal resistance", text: $thermalCalcs.thermalResistanceJuncToAmbString)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
            }
                
            // Calculate button section
            Section() {
                HStack {
                    Button(action: {
                        // Firstly, convert the strings to doubles
                        self.thermalCalcs.ambientTemperature = Double(self.thermalCalcs.ambientTemperatureString) ?? 0.0
                        self.thermalCalcs.maxAllowableTemperature = Double(self.thermalCalcs.maxAllowableTemperatureString) ?? 0.0
                        self.thermalCalcs.powerDissipated = Double(self.thermalCalcs.powerDissipatedString) ?? 0.0
                        self.thermalCalcs.thermalResistanceJuncToCase = Double(self.thermalCalcs.thermalResistanceJuncToCaseString) ?? 0.0
                        self.thermalCalcs.thermalResistanceJuncToAmb = Double(self.thermalCalcs.thermalResistanceJuncToAmbString) ?? 0.0
                        
                        self.thermalCalcs.calcHeatsinkRequirement()
                        
                        // If all conditions are met, play the success haptic
                        if (thermalCalcs.ambientHigherThanMax == false && thermalCalcs.negativePowerDissipated == false && thermalCalcs.negativePowerDissipated == false && thermalCalcs.negativeHeatsinkThermalResistance == false) {
                            if (settings.hapticsOn == true) { successHaptics() }
                        } else {
                            if (settings.hapticsOn == true) { errorHaptics() }
                        }
                    }) {
                        Text("Calculate")
                    }
                    // Hidden spacers to use to attach alerts
                    Spacer()
                        .alert(isPresented: $thermalCalcs.ambientHigherThanMax) {
                            Alert(title: Text("Ambient temperature higher than maximum"), message: Text("The ambient temperature is higher than or equal to the maximum temperature. Please check the values you have entered."), dismissButton: .default(Text("OK")))
                        }
                    Spacer()
                        .alert(isPresented: $thermalCalcs.negativePowerDissipated) {
                            Alert(title: Text("Device power dissipated is zero or negative"), message: Text("The device power dissipated is zero or negative. Please check the value you have entered."), dismissButton: .default(Text("OK")))
                        }
                    Spacer()
                        .alert(isPresented: $thermalCalcs.negativePowerDissipated) {
                            Alert(title: Text("Thermal resistance(s) are zero or negative"), message: Text("The thermal resistance(s) are zero or negative. Please check the value(s) you have entered."), dismissButton: .default(Text("OK")))
                        }
                    Spacer()
                        .alert(isPresented: $thermalCalcs.negativeHeatsinkThermalResistance) {
                            Alert(title: Text("The device will overheat with the power dissipated"), message: Text("The power dissipated is too high for the device - the device will overheat. Please check your values, or change the device if required."), dismissButton: .default(Text("OK")))
                        }
                }
                
            }
                
            // Results section
            Section(header: Text("Results")) {
                if (thermalCalcs.noHeatsinkRequired == true) {
                    HStack {
                        Text("Heatsink required?")
                        Spacer()
                        Image(systemName: "xmark")
                    }
                } else {
                    HStack {
                        Text("Heatsink required?")
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                    HStack {
                        Text("Max heatsink thermal resistance:")
                        Spacer()
                        Text("\(thermalCalcs.heatsinkThermalResistance, specifier: "%.\(settings.decimalPlaces)f")ºC/W")
                    }
                }
            
            }
            
            Section(header: Text("Explanation")) {
                Text("This calculator calculates whether a heatsink is required to cool a device, and if so, what the maximum allowable thermal resistance of that heatsink is.")
                // Add Wikipedia article link
                if #available(iOS 14.0, *) {
                    Link(destination: URL(string: "https://en.wikipedia.org/wiki/Thermal_resistance")!, label: {
                        Text("Article about thermal resistance on Wikipedia")
                    })
                } else {
                    // Links were only introduced in iOS 14, so the workaround is to use UIKit links.
                    Button("Article about thermal resistance on Wikipedia") {
                        UIApplication.shared.open(URL(string: "https://en.wikipedia.org/wiki/Thermal_resistance")!)
                    }
                }
            }
            
        
        }
        .navigationBarTitle(String("Heatsink Calculator"))
    }
}

struct ThermalResistanceCalculator_Previews: PreviewProvider {
    static var previews: some View {
        ThermalResistanceCalculator()
    }
}
