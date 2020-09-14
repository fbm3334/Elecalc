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
    
    @ViewBuilder
    var body: some View {
        Form {
            // Temperature entry
            Section(header: Text("Temperatures")) {
                // HStack to store value rows
                HStack {
                    Text("Ambient (ºC)")
                    Spacer()
                    TextField(String("Temperature"), value: $thermalCalcs.ambientTemperature, formatter: doubleFormatter)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Max temperature (ºC)")
                    Spacer()
                    TextField(String("Temperature"), value: $thermalCalcs.maxAllowableTemperature, formatter: doubleFormatter)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            // Power dissipated
            Section(header: Text("Power dissipation")) {
                HStack {
                    Text("Device power dissipated (W)")
                    Spacer()
                    TextField(String("Power"), value: $thermalCalcs.powerDissipated, formatter: doubleFormatter)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
            }
                
            // Thermal resistance values (junction to case and junction to ambient)
            Section(header: Text("Thermal resistances")) {
                HStack {
                    Text("Junction to case (ºC/W)")
                    Spacer()
                    TextField(String("Power"), value: $thermalCalcs.thermalResistanceJuncToCase, formatter: doubleFormatter)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Junction to ambient (ºC/W)")
                    Spacer()
                    TextField(String("Power"), value: $thermalCalcs.thermalResistanceJuncToAmb, formatter: doubleFormatter)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
            }
                
            // Calculate button section
            Section() {
                HStack {
                    Button(action: {
                        self.thermalCalcs.calcHeatsinkRequirement()
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
                        Text("\(thermalCalcs.heatsinkThermalResistance, specifier: "%.2f")ºC/W")
                    }
                }
            
            }
            
        .navigationBarTitle(String("Heatsink Calculator"))
        }
        
        
        
    }
}

struct ThermalResistanceCalculator_Previews: PreviewProvider {
    static var previews: some View {
        ThermalResistanceCalculator()
    }
}
