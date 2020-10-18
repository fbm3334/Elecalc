//
//  PotentialDividerView.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 19/09/2020.
//

import SwiftUI

struct PotentialDivider: View {
    
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    @EnvironmentObject var settings: Settings
    
    // Variables for view
    @State var supplyVoltage: Double = 0.0
    @State var supplyVoltageString: String = "0"
    @State var resistor1 = SIValue(value: 0.0, prefix: .none)
    @State var resistor1String: String = "0"
    @State var resistor2 = SIValue(value: 0.0, prefix: .none)
    @State var resistor2String: String = "0"
    @State var outputVoltage: Double = 0.0
    
    // Flags for invalid values
    @State var supplyVoltageZeroOrLess: Bool = false
    @State var resistorLessThanZero: Bool = false
    
    var body: some View {
        Form {
            // First section - Supply voltage
            Section(header: Text("Supply voltage")) {
                HStack {
                    Text("Supply voltage (V):")
                    Spacer()
                    TextField("Voltage", text: $supplyVoltageString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            // Second section - Resistor 1
            Section(header: Text("Resistor 1 (R1)")) {
                HStack {
                    Text("Resistance value:")
                    Spacer()
                    TextField("Resistance", text: $resistor1String)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                VStack {
                    HStack {
                        Text("Prefix:")
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Picker(selection: $resistor1.prefix, label: Text("Prefix")) {
                        ForEach(SIPrefixes.allCases, id: \.self) {
                            Text(String("\($0.description)Ω"))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
            // Third section - Resistor 2
            Section(header: Text("Resistor 2 (R2)")) {
                HStack {
                    Text("Resistance value:")
                    Spacer()
                    TextField("Resistance", text: $resistor2String)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                VStack {
                    HStack {
                        Text("Prefix:")
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Picker(selection: $resistor2.prefix, label: Text("Prefix")) {
                        ForEach(SIPrefixes.allCases, id: \.self) {
                            Text(String("\($0.description)Ω"))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
            // Calculate button section
            Section() {
                HStack {
                    Button(action: {
                        // Convert the strings to doubles
                        supplyVoltage = Double(supplyVoltageString) ?? 0.0
                        resistor1.value = Double(resistor1String) ?? -1.0
                        resistor2.value = Double(resistor2String) ?? -1.0
                        
                        // Validate the values
                        if (supplyVoltage <= 0.0) {
                            supplyVoltageZeroOrLess = true
                            if (settings.hapticsOn == true) { errorHaptics() }
                        } else if (resistor1.value < 0 || resistor2.value < 0) {
                            resistorLessThanZero = true
                            if (settings.hapticsOn == true) { errorHaptics() }
                        } else {
                            if (settings.hapticsOn == true) { successHaptics() }
                            outputVoltage = resistorCalcs.calcPotentialDividerVoltage(supplyVoltage: supplyVoltage, r1: resistor1, r2: resistor2)
                        }
                        
                    }) {
                        Text("Calculate")
                    }
                    Spacer().alert(isPresented: $supplyVoltageZeroOrLess) {
                        Alert(title: Text("Supply voltage is zero or less"), message: Text("Please check your value."), dismissButton: .default(Text("OK")))
                    }
                    Spacer().alert(isPresented: $resistorLessThanZero) {
                        Alert(title: Text("One or both of your resistor values are less than zero."), message: Text("Please check your values."), dismissButton: .default(Text("OK")))
                    }
                }
            }
            
            // Results section
            Section(header: Text("Results")) {
                HStack {
                    Text("Output voltage:")
                        .bold()
                    Spacer()
                    Text("\(outputVoltage, specifier: "%.\(settings.decimalPlaces)f")V")
                        .multilineTextAlignment(.trailing)
                }
            }
            
            // Explanation section
            Section(header: Text("About this calculation")) {
                Text("This calculator calculates the output voltage of a potential divider network, with R2 being the resistor where the output voltage is dropped.")
                
                // Place the image into a HStack with spacers to centre it properly
                HStack {
                    Spacer()
                    Image("PotentialDivider")
                        .resizable()
                        .frame(width: 300, height: 210, alignment: .center)
                    Spacer()
                }
                
                VStack {
                    Text("The equation used is:")
                    HStack {
                        Spacer()
                        Image("PotentialDividerEqn")
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle(Text("Potential Divider Calculator"))
    }
}

struct PotentialDivider_Previews: PreviewProvider {
    static var previews: some View {
        PotentialDivider()
    }
}
