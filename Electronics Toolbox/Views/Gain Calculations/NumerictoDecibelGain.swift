//
//  NumerictoDecibelGain.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 18/09/2020.
//

import SwiftUI

import SwiftUI

struct NumerictoDecibelGain: View {
    
    @EnvironmentObject var gainCalcs: GainCalcs
    @EnvironmentObject var settings: Settings
    @State var gainType: DecibelGains = .amplitude
    @State var dBGain: Double = 0.0
    @State var numericGain: Double = 0.0
    @State var numericGainString: String = "0"
    
    var body: some View {
        Form {
            Section(header: Text("Numeric Gain")) {
                Picker(selection: $gainType, label: Text("Gain type")) {
                    ForEach(DecibelGains.allCases, id: \.self) {
                        Text(String($0.description))
                    }
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // TextField for entering gain
                HStack {
                    Text("Numeric Gain")
                    Spacer()
                    TextField("Gain", text: $numericGainString)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            // Section for calculate button
            Section() {
                Button(action: {
                    // Play the success haptic
                    if (settings.hapticsOn == true) { successHaptics() }
                    // Convert the dB gain string into a double
                    numericGain = Double(numericGainString) ?? 0.0
                    dBGain = gainCalcs.numericToDecibelGain(numericGain: numericGain, gainType: gainType)
                }) {
                    Text("Calculate")
                }
            }
            
            // Section to show results
            Section(header: Text("Results")) {
                HStack {
                    Text("dB Gain:")
                        .bold()
                    Spacer()
                    Text("\(dBGain, specifier: "%.\(settings.decimalPlaces)f")dB")
                }
            }
            
            Section(header: Text("Explanation")) {
                Text("This calculator converts a numeric gain to a dB gain.")
            }
        }
        .navigationBarTitle("Numeric to dB Gain")
    }
}

struct NumerictoDecibelGain_Previews: PreviewProvider {
    static var previews: some View {
        NumerictoDecibelGain()
    }
}
