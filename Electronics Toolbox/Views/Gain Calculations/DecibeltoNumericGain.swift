//
//  DecibeltoNumericGainView.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 17/09/2020.
//

import SwiftUI

struct DecibeltoNumericGain: View {
    
    @EnvironmentObject var gainCalcs: GainCalcs
    @State var gainType: DecibelGains = .amplitude
    @State var dBGain: Double = 0.0
    @State var dBGainString: String = "0"
    @State var numericGain: Double = 0.0
    
    var body: some View {
        Form {
            Section(header: Text("Decibel Gain")) {
                Picker(selection: $gainType, label: Text("Gain type")) {
                    ForEach(DecibelGains.allCases, id: \.self) {
                        Text(String($0.description))
                    }
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // TextField for entering gain
                HStack {
                    Text("dB Gain")
                    Spacer()
                    TextField("Gain", text: $dBGainString)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            // Section for calculate button
            Section() {
                Button(action: {
                    // Convert the dB gain string into a double
                    dBGain = Double(dBGainString) ?? 0.0
                    numericGain = gainCalcs.decibelToNumericGain(dBGain: dBGain, gainType: gainType)
                }) {
                    Text("Calculate")
                }
            }
            
            // Section to show results
            Section(header: Text("Results")) {
                HStack {
                    Text("Numeric gain:")
                        .bold()
                    Spacer()
                    Text("\(numericGain, specifier: "%.2f")")
                }
            }
        }
        .navigationBarTitle("dB to Numeric Gain")
    }
}

struct DecibeltoNumericGain_Previews: PreviewProvider {
    static var previews: some View {
        DecibeltoNumericGain()
    }
}