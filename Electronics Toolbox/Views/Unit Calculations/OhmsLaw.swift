//
//  OhmsLaw.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 27/09/2020.
//

import SwiftUI

enum OhmsLawUnknown: Int, CustomStringConvertible, CaseIterable {
    case voltage, current, resistance
    
    var description: String {
        switch self {
        case .voltage: return "Voltage"
        case .current: return "Current"
        case .resistance: return "Resistance"
        }
    }
}

struct OhmsLaw: View {
    @EnvironmentObject var unitCalcs: UnitCalcs
    @EnvironmentObject var settings: Settings
    
    @State var unknownQuantity: OhmsLawUnknown = .voltage
    @State var inputVoltage = SIValue(value: 0.0, prefix: .none)
    @State var inputVoltageString = "0.0"
    @State var inputCurrent = SIValue(value: 0.0, prefix: .none)
    @State var inputCurrentString = "0.0"
    @State var inputResistance = SIValue(value: 0.0, prefix: .none)
    @State var inputResistanceString = "0.0"
    @State var outputVoltage = SIValue(value: 0.0, prefix: .none)
    @State var outputCurrent = SIValue(value: 0.0, prefix: .none)
    @State var outputResistance = SIValue(value: 0.0, prefix: .none)
    @State var valueZero = false
    
    // Pasteboard for clipboard
    let pasteboard = UIPasteboard.general
    
    // Number of decimal places
    @State var decimalPlaces = UserDefaults.standard.integer(forKey: "DecimalPlaces")
    
    var body: some View {
        Form {
            Section(header: Text("Unknown quantity")) {
                Picker(selection: $unknownQuantity, label: Text("Unknown quantity")) {
                    ForEach(OhmsLawUnknown.allCases, id: \.self) {
                        Text(String($0.description))
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Input values")) {
                // Pick the correct input values to show based on the view
                // If calculating current or resistance, show the voltage
                if (unknownQuantity == .current || unknownQuantity == .resistance) {
                    VStack {
                        HStack {
                            Text("Voltage:")
                            Spacer()
                            TextField(String("Voltage"), text: $inputVoltageString)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker(selection: $inputVoltage.prefix, label: Text("Unknown quantity")) {
                            ForEach(SIPrefixes.allCases, id: \.self) {
                                Text(String("\($0.description)V"))
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                // If calculating voltage or resistance, show the current
                if (unknownQuantity == .voltage || unknownQuantity == .resistance) {
                    VStack {
                        HStack {
                            Text("Current:")
                            Spacer()
                            TextField(String("Current"), text: $inputCurrentString)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker(selection: $inputCurrent.prefix, label: Text("Unknown quantity")) {
                            ForEach(SIPrefixes.allCases, id: \.self) {
                                Text(String("\($0.description)A"))
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                // If calculating voltage or current, show the resistance
                if (unknownQuantity == .current || unknownQuantity == .voltage) {
                    VStack {
                        HStack {
                            Text("Resistance:")
                            Spacer()
                            TextField(String("Resistance"), text: $inputResistanceString)
                                .keyboardType(.decimalPad)
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
                    // Convert the values
                    inputVoltage.value = (Double(inputVoltageString) ?? 0.0).magnitude
                    inputCurrent.value = (Double(inputCurrentString) ?? 0.0).magnitude
                    inputResistance.value = (Double(inputResistanceString) ?? 0.0).magnitude
                    // Check whether values are zero
                    switch (unknownQuantity) {
                    case .voltage:
                        if (inputCurrent.value == 0.0 || inputResistance.value == 0.0) { valueZero = true }
                    case .current:
                        if (inputVoltage.value == 0.0 || inputResistance.value == 0.0) { valueZero = true }
                    case .resistance:
                        if (inputVoltage.value == 0.0 || inputCurrent.value == 0.0) { valueZero = true }
                    }
                    // Play the error haptics if the values are zero
                    if (valueZero == true) {
                        if (settings.hapticsOn == true) { errorHaptics() }
                    } else {
                    // Vary the action based on which unknown quantity
                        
                        switch (unknownQuantity) {
                        case .voltage:
                            outputVoltage = unitCalcs.calcVoltage(current: inputCurrent, resistance: inputResistance)
                        case .current:
                            outputCurrent = unitCalcs.calcCurrent(voltage: inputVoltage, resistance: inputResistance)
                        case .resistance:
                            outputResistance = unitCalcs.calcResistance(voltage: inputVoltage, current: inputCurrent)
                        }
                        // Play the success haptic
                        if (settings.hapticsOn == true) { successHaptics() }
                    }
                }) {
                    Text("Calculate")
                }.alert(isPresented: $valueZero) {
                    Alert(title: Text("One or more of your values is zero."), message: Text("Please check your values."), dismissButton: .default(Text("OK")))
                }
            }
            
            // Results section
            Section(header: Text("Results")) {
                if (unknownQuantity == .voltage) {
                    HStack {
                        Text("Voltage:")
                            .bold()
                        Spacer()
                        Text("\(outputVoltage.value, specifier: "%.\(settings.decimalPlaces)f")\(outputVoltage.prefix.description)V")
                        // Clipboard button
                        Button(action: {
                            pasteboard.string = "\(outputVoltage.value)\(outputVoltage.prefix.description)V"
                        }) {
                            Image(systemName: "doc.on.doc")
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                } else if (unknownQuantity == .current) {
                    HStack {
                        Text("Current:")
                            .bold()
                        Spacer()
                        Text("\(outputCurrent.value, specifier: "%.\(settings.decimalPlaces)f")\(outputCurrent.prefix.description)A")
                        // Clipboard button
                        Button(action: {
                            pasteboard.string = "\(outputCurrent.value)\(outputCurrent.prefix.description)A"
                        }) {
                            Image(systemName: "doc.on.doc")
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                } else {
                    HStack {
                        Text("Resistance:")
                            .bold()
                        Spacer()
                        Text("\(outputResistance.value, specifier: "%.\(settings.decimalPlaces)f")\(outputResistance.prefix.description)Ω")
                        // Clipboard button
                        Button(action: {
                            pasteboard.string = "\(outputResistance.value)\(outputResistance.prefix.description)Ω"
                        }) {
                            Image(systemName: "doc.on.doc")
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            
            // Explanation section
            Section(header: Text("Explanation")) {
                Text("This calculator uses Ohm's Law to calculate the voltage, current or resistance.")
                HStack {
                    Spacer()
                    Image("OhmsEqns")
                    Spacer()
                }
                
            }
            
        }.navigationBarTitle(String("Ohm's Law Calculator"))
    }
}

struct OhmsLaw_Previews: PreviewProvider {
    static var previews: some View {
        OhmsLaw()
    }
}
