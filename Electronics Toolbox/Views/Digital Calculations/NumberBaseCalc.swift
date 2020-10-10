//
//  NumberBaseCalc.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 09/10/2020.
//

import SwiftUI
import Combine

struct NumberBaseCalc: View {
    @EnvironmentObject var digitalCalcs: DigitalCalcs
    @State var binNumberIn = ""
    @State var octNumberIn = ""
    @State var decNumberIn = ""
    @State var hexNumberIn = ""
    @State var binConverted = String(repeating: "0", count: 32)
    @State var decConverted: Int = 0
    @State var hexConverted: String = ""
    @State var inputBase: NumberBase = .bin
    @State var inputSigned: Bool = false
    
    
    var body: some View {
        Form {
            
            // Section 1 - Base and signed
            Section(header: Text("Base and type")) {
                HStack {
                    Text("Base:")
                    Picker(selection: $inputBase, label: Text("Base")) {
                        ForEach(NumberBase.allCases, id: \.self) {
                            Text(String("\($0.description)"))
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    Text("Signed number")
                    Spacer()
                    Toggle("Signed number", isOn: $inputSigned)
                        .labelsHidden()
                }
            }
            
            Section(header: Text("Number entry")) {
                // If statement to choose the section based on the base selected
                if (inputBase == .bin) {
                    VStack(alignment: .leading) {
                        Text("Binary number:")
                        TextField("Enter a binary number", text: $binNumberIn)
                            .font(.system(size: 16, design: .monospaced))
                            .onReceive(Just(binNumberIn)) { (newValue: String) in
                                self.binNumberIn = newValue.prefix(32).filter {
                                    digitalCalcs.binAllowedCharacters.contains($0)
                                }
                            }
                    }
                    
                    // Autofill button
                    Button(action: {
                        binNumberIn = digitalCalcs.autoFill(field: binNumberIn, base: .bin)
                    }) {
                        VStack(alignment: .leading) {
                            Text("Autofill")
                            Text("Fills all 32 bits with the leftmost digit.")
                                .font(.caption)
                        }
                    }
                }
                
                // Decimal number - no autofill
                if (inputBase == .dec) {
                    VStack(alignment: .leading) {
                        Text("Decimal number:")
                        TextField("Enter a decimal number", text: $decNumberIn)
                            .font(.system(size: 16, design: .monospaced))
                            .onReceive(Just(decNumberIn)) { (newValue: String) in
                                self.decNumberIn = newValue.prefix(10).filter {
                                    digitalCalcs.decAllowedCharacters.contains($0)
                                }
                            }
                    }
                }
                
                // Hexadecimal number
                if (inputBase == .hex) {
                    VStack(alignment: .leading) {
                        Text("Hexadecimal number:")
                        TextField("Enter a hexadecimal number", text: $hexNumberIn)
                            .font(.system(size: 16, design: .monospaced))
                            .onReceive(Just(hexNumberIn)) { (newValue: String) in
                                self.hexNumberIn = newValue.prefix(8).uppercased().filter {
                                    digitalCalcs.hexAllowedCharacters.contains($0)
                                }
                            }
                    }
                    
                    // Autofill button
                    Button(action: {
                        hexNumberIn = digitalCalcs.autoFill(field: hexNumberIn, base: .hex)
                    }) {
                        VStack(alignment: .leading) {
                            Text("Autofill")
                            Text("Fills all hexadecimal digits with the leftmost digit.")
                                .font(.caption)
                        }
                    }
                }
            }
            
            // Convert button
            Section() {
                Button(action: {
                    convertNumberBase()
                }) {
                    Text("Convert")
                }
            }
            
            // Results section
            Section(header: Text("Results")) {
                Text(binConverted)
                Text(String(decConverted))
                Text(hexConverted)
            }
        }
        .navigationBarTitle(Text("Number Base Converter"))
    }
    
    func convertNumberBase() {
        // Case statement for number base
        switch inputBase {
        
        case .bin:
            // First, convert the binary to decimal.
            decConverted = digitalCalcs.binToDec(binNumber: binNumberIn, signed: inputSigned)
            // Then convert back to binary and store in binConverted
            
        case .dec:
            // Copy the decimal number to decConverted
        decConverted = Int(decNumberIn) ?? 0
            // If unsigned, then take the absolute value
            if (inputSigned == false) { decConverted = abs(decConverted) }
        case .hex:
            // Convert the hexadecimal to decimal.
            decConverted = digitalCalcs.hexToDec(hexNumber: hexNumberIn, signed: inputSigned)
        }
        
        // Convert the decimal to binary.
        binConverted = digitalCalcs.decToBin(decNumber: decConverted, signed: inputSigned)
        // Convert the decimal to hexadecimal.
        hexConverted = digitalCalcs.decToHex(decNumber: decConverted, signed: inputSigned)
    }
    
}

struct NumberBaseCalc_Previews: PreviewProvider {
    static var previews: some View {
        NumberBaseCalc()
    }
}
