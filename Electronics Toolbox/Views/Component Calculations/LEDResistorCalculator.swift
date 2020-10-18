//
//  LEDResistorCalculator.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 18/09/2020.
//

import SwiftUI

struct LEDResistorCalculator: View {
    
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    @EnvironmentObject var settings: Settings
    
    // Variables for view
    @State var supplyVoltage: Double = 0.0
    @State var supplyVoltageString: String = "0"
    @State var ledVoltage: Double = 0.0
    @State var ledVoltageString: String = "0"
    @State var ledCurrent: Double = 0.0
    @State var ledCurrentString: String = "0"
    @State var resistorValue = SIValue(value: 0, prefix: .none)
    
    // Flags - show alerts if parameters out of bounds
    @State var supplyVoltageZero: Bool = false
    @State var ledVoltageGreaterThanSupply: Bool = false
    @State var ledCurrentZero: Bool = false
    
    var body: some View {
        Form {
            
            Section(header: Text("Voltage and Current Values")) {
                // Supply voltage
                HStack {
                    Text("Supply voltage (V)")
                    Spacer()
                    TextField(String("Voltage"), text: $supplyVoltageString)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                // LED forward voltage
                HStack {
                    Text("LED forward voltage (V)")
                    Spacer()
                    TextField(String("Voltage"), text: $ledVoltageString)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                // LED forward current
                HStack {
                    Text("LED forward current (mA)")
                    Spacer()
                    TextField(String("Current"), text: $ledCurrentString)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
            }
            
            // Section with the calculate button
            Section() {
                HStack {
                    Button(action: {
                        // Convert the voltage/current strings to doubles
                        supplyVoltage = Double(supplyVoltageString) ?? 0.0
                        ledVoltage = Double(ledVoltageString) ?? 0.0
                        ledCurrent = Double(ledCurrentString) ?? 0.0
                        
                        // Validate the values before passing into function
                        if (supplyVoltage <= 0) {
                            supplyVoltageZero = true
                            if (settings.hapticsOn == true) { errorHaptics() }
                        } else if (ledVoltage >= supplyVoltage) {
                            ledVoltageGreaterThanSupply = true
                            if (settings.hapticsOn == true) { errorHaptics() }
                        } else if (ledCurrent <= 0) {
                            ledCurrentZero = true
                            if (settings.hapticsOn == true) { errorHaptics() }
                        } else {
                            // Run function
                            resistorValue = resistorCalcs.calcLEDResistor(supplyVoltage: supplyVoltage, ledVoltage: ledVoltage, ledCurrent: ledCurrent / 1000)
                            if (settings.hapticsOn == true) { successHaptics() }
                        }
                    }) {
                        Text("Calculate")
                    }
                    // Added spacers to attach alerts onto
                    Spacer()
                        .alert(isPresented: $supplyVoltageZero, content: {
                            Alert(title: Text("The supply voltage is less than or equal to zero"), message: Text("The supply voltage is less than or equal to zero. Please check the values you have entered."), dismissButton: .default(Text("OK")))
                        })
                    Spacer()
                        .alert(isPresented: $ledVoltageGreaterThanSupply, content: {
                            Alert(title: Text("The LED forward voltage is greater than or equal to the supply voltage"), message: Text("The LED forward voltage is greater than or equal to the supply voltage. Please check the values you have entered."), dismissButton: .default(Text("OK")))
                        })
                    Spacer()
                        .alert(isPresented: $ledCurrentZero, content: {
                            Alert(title: Text("The LED forward current is less than or equal to zero"), message: Text("The LED forward current is less than or equal to zero. Please check the values you have entered."), dismissButton: .default(Text("OK")))
                        })
                    }
                }
            // Results section
            Section(header: Text("Results")) {
                HStack {
                    Text("Minimum resistance:")
                        .bold()
                    Spacer()
                    Text("\(resistorValue.value, specifier: "%.\(settings.decimalPlaces)f")\(resistorValue.prefix.description)Ω")
                }
                
            }
            // Explanation section
            Section(header: Text("Explanation")) {
                Text("This calculator calculates the required current-limiting resistor in series with an LED.")
            }
        }
        .navigationBarTitle(Text("LED Current-Limiting Resistor"))
    }
}

struct LEDResistorCalculator_Previews: PreviewProvider {
    static var previews: some View {
        LEDResistorCalculator()
    }
}
