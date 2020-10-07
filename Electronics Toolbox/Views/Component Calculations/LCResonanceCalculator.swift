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
    @State var inductorValue = InductorValue(value: 0.0, prefix: .H)
    @State var inductorValueString = "0.0"
    @State var capacitorValue = CapacitorValue(value: 0.0, prefix: .F)
    @State var capacitorValueString = "0.0"
    @State var valuesInvalid = false
    @State var frequency = FrequencyValue(value: 0.0, prefix: .Hz)
        
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
                    }
                    Picker(selection: $inductorValue.prefix, label: Text("Inductance prefix")) {
                        ForEach(SIInductorPrefixes.allCases, id: \.self) {
                            Text(String($0.description))
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
                    }
                    Picker(selection: $capacitorValue.prefix, label: Text("Capacitance prefix")) {
                        ForEach(SICapacitorPrefixes.allCases, id: \.self) {
                            Text(String("\($0.description)"))
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
                    } else {
                        frequency = lcResonanceCalc.calcLCResFreq(inductance: inductorValue, capacitance: capacitorValue)
                    }
                }) {
                    Text("Calculate")
                }
            }
            
            // Results section
            Section(header: Text("Results")) {
                HStack {
                    Text("Frequency:")
                        .bold()
                    Spacer()
                    Text("\(frequency.value, specifier: "%.\(settings.decimalPlaces)f")\(frequency.prefix.description)")
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
