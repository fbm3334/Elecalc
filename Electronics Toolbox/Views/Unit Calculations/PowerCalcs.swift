//
//  PowerCalcs.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 27/09/2020.
//

import SwiftUI

enum PowerCalcsKnownQuantities: Int, CustomStringConvertible, CaseIterable {
    case voltageCurrent, voltageResistance, currentResistance
    
    var description: String {
        switch self {
        case .voltageCurrent:
            return "Voltage and current"
        case .voltageResistance:
            return "Voltage and resistance"
        case .currentResistance:
            return "Current and resistance"
        }
    }
}

struct PowerCalcs: View {
    @EnvironmentObject var unitCalcs: UnitCalcs
    @EnvironmentObject var settings: Settings
    
    @State var knownQuantities: PowerCalcsKnownQuantities = .voltageCurrent
    @State var inputVoltage = SIValue(value: 0.0, prefix: .none)
    @State var inputVoltageString = "0.0"
    @State var inputCurrent = SIValue(value: 0.0, prefix: .none)
    @State var inputCurrentString = "0.0"
    @State var inputResistance = SIValue(value: 0.0, prefix: .none)
    @State var inputResistanceString = "0.0"
    @State var outputPower = SIValue(value: 0.0, prefix: .none)
    @State var valueZero = false
    
    var body: some View {
        Form {
            Section(header: Text("Known quantities")) {
                Picker(selection: $knownQuantities, label: Text("Known quantities")) {
                    ForEach(PowerCalcsKnownQuantities.allCases, id: \.self) {
                        Text(String($0.description))
                    }
                }
            }
            
            Section(header: Text("Input values")) {
                // Pick the correct input values to show based on the view
                // Show voltage if required
                if (knownQuantities == .voltageCurrent || knownQuantities == .voltageResistance) {
                    VStack {
                        HStack {
                            Text("Voltage:")
                            Spacer()
                            TextField(String("Voltage"), text: $inputVoltageString)
                                .keyboardType(.numbersAndPunctuation)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker(selection: $inputVoltage.prefix, label: Text("Unknown quantity")) {
                            ForEach(SIPrefixes.allCases, id: \.self) {
                                Text(String("\($0.description)V"))
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                // Show current if required
                if (knownQuantities == .voltageCurrent || knownQuantities == .currentResistance) {
                    VStack {
                        HStack {
                            Text("Current:")
                            Spacer()
                            TextField(String("Current"), text: $inputCurrentString)
                                .keyboardType(.numbersAndPunctuation)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker(selection: $inputCurrent.prefix, label: Text("Unknown quantity")) {
                            ForEach(SIPrefixes.allCases, id: \.self) {
                                Text(String("\($0.description)A"))
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                // Show resistance if required
                if (knownQuantities == .voltageResistance || knownQuantities == .currentResistance) {
                    VStack {
                        HStack {
                            Text("Resistance:")
                            Spacer()
                            TextField(String("Resistance"), text: $inputResistanceString)
                                .keyboardType(.numbersAndPunctuation)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker(selection: $inputResistance.prefix, label: Text("Unknown quantity")) {
                            ForEach(SIPrefixes.allCases, id: \.self) {
                                Text(String("\($0.description)Ω"))
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            
            Section() {
                Button(action: {
                    // Print the strings
                    print("\(inputVoltageString)|\(inputCurrentString)|\(inputResistanceString)")
                    // Convert the values
                    inputVoltage.value = (Double(inputVoltageString) ?? 0.0).magnitude
                    inputCurrent.value = (Double(inputCurrentString) ?? 0.0).magnitude
                    inputResistance.value = (Double(inputResistanceString) ?? 0.0).magnitude
                    
                    print("\(inputVoltage.value)|\(inputCurrent.value)|\(inputResistance.value)")
                    // Check whether values are zero by using a switch..case statement
                    switch (knownQuantities) {
                    case .voltageCurrent:
                        if (inputVoltage.value == 0 || inputCurrent.value == 0) { valueZero = true }
                    case .voltageResistance:
                        if (inputVoltage.value == 0 || inputResistance.value == 0) { valueZero = true }
                    case .currentResistance:
                        if (inputResistance.value == 0 || inputCurrent.value == 0) { valueZero = true }
                    }
                    if (valueZero == false) {
                        // Play the success haptic
                        if (settings.hapticsOn == true) { successHaptics() }
                    // Vary the action based on which unknown quantity
                        switch (knownQuantities) {
                        case .voltageCurrent:
                            outputPower = unitCalcs.calcPowerCurrentVoltage(voltage: inputVoltage, current: inputCurrent)
                        case .currentResistance:
                            outputPower = unitCalcs.calcPowerCurrentResistance(current: inputCurrent, resistance: inputResistance)
                        case .voltageResistance:
                            outputPower = unitCalcs.calcPowerVoltageResistance(voltage: inputVoltage, resistance: inputResistance)
                        }
                    } else {
                        // Play the error haptic
                        if (settings.hapticsOn == true) { errorHaptics() }
                    }
                }) {
                    Text("Calculate")
                }.alert(isPresented: $valueZero) {
                    Alert(title: Text("One or more of your values is zero."), message: Text("Please check your values."), dismissButton: .default(Text("OK")))
                }
            }
            
            // Results section
            Section(header: Text("Results")) {
                HStack {
                    Text("Power:")
                        .bold()
                    Spacer()
                    Text("\(outputPower.value, specifier: "%.\(settings.decimalPlaces)f")\(outputPower.prefix.description)W")
                }
            }
            
            // Explanation section
            Section(header: Text("Explanation")) {
                Text("This calculator uses the simple power equations below to calculate the power consumption.")
                HStack {
                    Spacer()
                    Image("PowerEqns")
                    Spacer()
                }
                
            }
            
        }.navigationBarTitle(String("Power Calculator"))
    }
}

struct PowerCalcs_Previews: PreviewProvider {
    static var previews: some View {
        PowerCalcs()
    }
}

