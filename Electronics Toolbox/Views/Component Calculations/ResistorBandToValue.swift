//
//  ResistorBandToValue.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 31/08/2020.
//

import SwiftUI

struct ResistorBandToValue: View {
    
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    @EnvironmentObject var settings: Settings
    
    @ViewBuilder
    var body: some View {
        // List of values
        Form {
            Section(header: Text("Number of resistor bands")) {
                VStack {
                    HStack {
                        Text("Number of resistor bands")
                        Spacer()
                    }
                    Picker(selection: $resistorCalcs.numberOfBands, label: Text("Number of bands")) {
                        ForEach(NumberOfResistorBands.allCases, id: \.self) {
                            Text(String($0.description))
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
            }
                
            // Section for values (variable based on number of bands selected
            Section(header: Text("Resistor bands")) {
            // Four bands - first two digits, multiplier and tolerance
            // Five bands - first three digits, multiplier and tolerance
                Picker(selection: $resistorCalcs.bandDigit1, label: Text("First band")) {
                    ForEach(ResistorColourCode.allCases, id: \.self) {
                        Text(String($0.description))
                    }
                    //.navigationBarTitle("First band")
                }
                
                Picker(selection: $resistorCalcs.bandDigit2, label: Text("Second band")) {
                    ForEach(ResistorColourCode.allCases, id: \.self) {
                        Text(String($0.description))
                    }
                    //.navigationBarTitle("Second band")
                }
                
                // Show third digit picker if resistor does not equal four bands
                if (resistorCalcs.numberOfBands != .four) {
                    Picker(selection: $resistorCalcs.bandDigit3, label: Text("Third band")) {
                        ForEach(ResistorColourCode.allCases, id: \.self) {
                            Text(String($0.description))
                        }
                        //.navigationBarTitle("Third band")
                    }
                    
                    Picker(selection: $resistorCalcs.multiplier, label: Text("Fourth band (multiplier)")) {
                        ForEach(ResistorMultiplier.allCases, id: \.self) {
                            Text(String($0.description))
                        }
                        //.navigationBarTitle("Fourth band (multiplier)")
                    }
                    
                    Picker(selection: $resistorCalcs.tolerance, label: Text("Fifth band (tolerance)")) {
                        ForEach(ResistorTolerance.allCases, id: \.self) {
                            Text(String($0.description))
                        }
                        //.navigationBarTitle("Fifth band (tolerance)")
                    }
                    
                } else {
                    Picker(selection: $resistorCalcs.multiplier, label: Text("Third band (multiplier)")) {
                        ForEach(ResistorMultiplier.allCases, id: \.self) {
                            Text(String($0.description))
                        }
                        //.navigationBarTitle("Third band (multiplier)")
                    }
                    
                    Picker(selection: $resistorCalcs.tolerance, label: Text("Fourth band (tolerance)")) {
                        ForEach(ResistorTolerance.allCases, id: \.self) {
                            Text(String($0.description))
                        }
                        //.navigationBarTitle("Fourth band (tolerance)")
                    }
                    
                }
            
                
            // Button to calculate
                Button(action: {
                    // Play success haptic
                    if (settings.hapticsOn == true) { successHaptics() }
                    self.resistorCalcs.calcResistorValuefromColourCode()
                }) {
                    Text("Calculate value")
                }
                
            }
            // Section for calculating the resistor value
            Section(header: Text("Calculated resistor value")) {
                HStack {
                    Text("Value:")
                        .bold()
                    Spacer()
                    Text("\(resistorCalcs.colourCodeResistor.value, specifier: "%.\(settings.decimalPlaces)f")\(resistorCalcs.colourCodeResistor.prefix.description)Ω")
                }
                HStack {
                    Text("Lower tolerance:")
                        .bold()
                    Spacer()
                    Text("\(resistorCalcs.ccResistorLowerTolerance.value, specifier: "%.\(settings.decimalPlaces)f")\(resistorCalcs.ccResistorLowerTolerance.prefix.description)Ω")
                }
                HStack {
                    Text("Upper tolerance:")
                        .bold()
                    Spacer()
                    Text("\(resistorCalcs.ccResistorUpperTolerance.value, specifier: "%.\(settings.decimalPlaces)f")\(resistorCalcs.ccResistorUpperTolerance.prefix.description)Ω")
                }
            }
            
            
        }
        .navigationBarTitle("Resistor Colour Code to Value")
    }
}

struct ResistorBandToValue_Previews: PreviewProvider {
    static var previews: some View {
        ResistorBandToValue()
    }
}
