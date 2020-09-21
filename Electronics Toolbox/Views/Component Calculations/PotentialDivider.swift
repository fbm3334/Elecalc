//
//  PotentialDividerView.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 19/09/2020.
//

import SwiftUI

struct PotentialDivider: View {
    
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    
    // Variables for view
    @State var supplyVoltage: Double = 0.0
    @State var supplyVoltageString: String = "0"
    @State var resistor1 = ResistorValue(value: 0.0, prefix: .Ω)
    @State var resistor1String: String = "0"
    @State var resistor2 = ResistorValue(value: 0.0, prefix: .Ω)
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
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            // Second section - Resistor 1
            Section(header: Text("Resistor 1")) {
                HStack {
                    Text("Resistance value:")
                    Spacer()
                    TextField("Resistance", text: $resistor1String)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
                VStack {
                    HStack {
                        Text("Prefix:")
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Picker(selection: $resistor1.prefix, label: Text("Prefix")) {
                        ForEach(SIResistorPrefixes.allCases, id: \.self) {
                            Text(String($0.description))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
            // Third section - Resistor 2
            Section(header: Text("Resistor 2")) {
                HStack {
                    Text("Resistance value:")
                    Spacer()
                    TextField("Resistance", text: $resistor2String)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
                VStack {
                    HStack {
                        Text("Prefix:")
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Picker(selection: $resistor2.prefix, label: Text("Prefix")) {
                        ForEach(SIResistorPrefixes.allCases, id: \.self) {
                            Text(String($0.description))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
            // Calculate button section
            Section() {
                Button(action: {
                    // Convert the strings to doubles
                    supplyVoltage = Double(supplyVoltageString) ?? 0.0
                    resistor1.value = Double(resistor1String) ?? -1.0
                    resistor2.value = Double(resistor2String) ?? -1.0
                    
                    // Validate the values
                    if (supplyVoltage <= 0.0) { supplyVoltageZeroOrLess = true }
                    else if (resistor1.value < 0 || resistor2.value < 0) { resistorLessThanZero = true }
                    else {
                        outputVoltage = resistorCalcs.calcPotentialDividerVoltage(supplyVoltage: supplyVoltage, r1: resistor1, r2: resistor2)
                    }
                    
                }) {
                    Text("Calculate")
                }
            }
            
            // Results section
            Section(header: Text("Results")) {
                HStack {
                    Text("Output voltage:")
                        .bold()
                    Spacer()
                    Text("\(outputVoltage, specifier: "%.2f")V")
                        .multilineTextAlignment(.trailing)
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
