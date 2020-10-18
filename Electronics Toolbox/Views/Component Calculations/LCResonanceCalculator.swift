//
//  LCResonanceCalculator.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 07/10/2020.
//

import SwiftUI

struct LCResonanceCalculator: View {
    
    @EnvironmentObject var lcResonanceCalc: LCResonanceCalc
    @EnvironmentObject var settings: Settings
    
    // View variables
    @State var inductorValue = SIValue(value: 0.0, prefix: .none)
    @State var inductorValueString = "0.0"
    @State var capacitorValue = SIValue(value: 0.0, prefix: .none)
    @State var capacitorValueString = "0.0"
    @State var valuesInvalid = false
    @State var frequency = SIValue(value: 0.0, prefix: .none)
        
    var body: some View {
        Form {
            Section(header: Text("Component values")) {
                // VStack for inductor value
                VStack {
                    HStack {
                        Text("Inductor value:")
                        Spacer()
                        TextField("Inductance", text: $inductorValueString)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    Picker(selection: $inductorValue.prefix, label: Text("Inductance prefix")) {
                        ForEach(SIPrefixes.allCases, id: \.self) {
                            Text(String("\($0.description)H"))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                // VStack for capacitor value
                VStack {
                    HStack {
                        Text("Capacitor value:")
                        Spacer()
                        TextField("Capacitance", text: $capacitorValueString)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    Picker(selection: $capacitorValue.prefix, label: Text("Capacitance prefix")) {
                        ForEach(SIPrefixes.allCases, id: \.self) {
                            Text(String("\($0.description)F"))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Section() {
                Button(action: {
                    // Convert the inductor and capacitor value strings to numbers
                    inductorValue.value = Double(inductorValueString) ?? 0.0
                    capacitorValue.value = Double(capacitorValueString) ?? 0.0
                    
                    // Validate the values to check that they are greater than zero
                    if (inductorValue.value <= 0.0 || capacitorValue.value <= 0.0) {
                        valuesInvalid = true
                        errorHaptics()
                    } else {
                        frequency = lcResonanceCalc.calcLCResFreq(inductance: inductorValue, capacitance: capacitorValue)
                        successHaptics()
                    }
                }) {
                    Text("Calculate")
                }.alert(isPresented: $valuesInvalid) {
                    Alert(title: Text("Your inductor and/or capacitor value are less than or equal to zero."), message: Text("Please check your value/s."), dismissButton: .default(Text("OK")))
                }
            }
            
            // Results section
            Section(header: Text("Results")) {
                HStack {
                    Text("Frequency (f):")
                        .bold()
                    Spacer()
                    Text("\(frequency.value, specifier: "%.\(settings.decimalPlaces)f")\(frequency.prefix.description)Hz")
                }
                HStack {
                    Text("Angular frequency (ω):")
                        .bold()
                    Spacer()
                    Text("\(frequency.value * 2 * Double.pi, specifier: "%.\(settings.decimalPlaces)f")\(frequency.prefix.description) rad s⁻¹")
                }
            }
            
            // Explanation section
            Section(header: Text("Explanation")) {
                Text("This calculator calculates the resonant frequency of an LC circuit (an inductor in series with a capacitor).")
                HStack {
                    Spacer()
                    Image("LCResonatorEqns")
                    Spacer()
                }
                    
            }
        }
        .navigationBarTitle(Text("LC Resonance Calculator"))
    }
}

struct LCResonanceCalculator_Previews: PreviewProvider {
    static var previews: some View {
        LCResonanceCalculator()
    }
}
