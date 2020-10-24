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
    @State var hexConverted: String = "0"
    @State var inputBase: NumberBase = .bin
    @State var inputSigned: Bool = false
    @State var binarySplit = ["0000", "0000", "0000", "0000", "0000", "0000", "0000", "0000"]
    @State var decimalCheckFailed = false
    @State private var autofillHelpAction: Int? = 0
    
    // Pasteboard for clipboard
    let pasteboard = UIPasteboard.general
    
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
                    Text("Signed (two's complement) number")
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
                            .keyboardType(.numberPad)
                            .font(.system(size: 16, design: .monospaced))
                            .onReceive(Just(binNumberIn)) { (newValue: String) in
                                self.binNumberIn = newValue.prefix(32).filter {
                                    digitalCalcs.binAllowedCharacters.contains($0)
                                }
                            }
                    }
                }
                
                // Decimal number - no autofill
                if (inputBase == .dec) {
                    VStack(alignment: .leading) {
                        Text("Decimal number:")
                        TextField("Enter a decimal number", text: $decNumberIn)
                            .keyboardType(.numberPad)
                            .font(.system(size: 16, design: .monospaced))
                            .onReceive(Just(decNumberIn)) { (newValue: String) in
                                self.decNumberIn = newValue.prefix(11).filter {
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
                            .keyboardType(.numbersAndPunctuation)
                            .font(.system(size: 16, design: .monospaced))
                            .onReceive(Just(hexNumberIn)) { (newValue: String) in
                                self.hexNumberIn = newValue.prefix(8).uppercased().filter {
                                    digitalCalcs.hexAllowedCharacters.contains($0)
                                }
                            }
                    }
                }
            }
            
            // Show the Autofill section if the number is binary or hexadecimal
            if (inputBase != .dec) {
                Section(header: Text("Autofill")) {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Play the success haptic
                            successHaptics()
                            if (inputBase == .bin) {
                                binNumberIn = digitalCalcs.autoFill(field: binNumberIn, base: .bin)
                            } else {
                                hexNumberIn = digitalCalcs.autoFill(field: hexNumberIn, base: .hex)
                            }
                        }) {
                            VStack {
                                Image(systemName: "chevron.left.2")
                                Text("Fill to left with MSB")
                                    .font(.caption)
                            }
                        }.buttonStyle(BorderlessButtonStyle())
                        Spacer()
                        Button(action: {
                            // Play the success haptic
                            successHaptics()
                            if (inputBase == .bin) {
                                binNumberIn = digitalCalcs.autoFillRight(field: binNumberIn, base: .bin)
                            } else {
                                hexNumberIn = digitalCalcs.autoFillRight(field: hexNumberIn, base: .hex)
                            }
                        }) {
                            VStack {
                                Image(systemName: "chevron.right.2")
                                Text("Fill to right with LSB")
                                    .font(.caption)
                            }
                        }.buttonStyle(BorderlessButtonStyle())
                        Spacer()
                    }
                }
            }
            
            // Convert button (with error if the decimal check fails)
            Section() {
                Button(action: {
                    convertNumberBase()
                }) {
                    Text("Convert")
                }.alert(isPresented: $decimalCheckFailed) {
                    Alert(title: Text("Decimal value out of range"), message: Text("The value entered was out of range. Please check your value."), dismissButton: .default(Text("OK")))
                }
            }
            
            // Binary results section
            Section(header: Text("Binary conversion")) {
                HStack {
                    Spacer()
                    binaryView(binarySplit: binarySplit)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Button(action: {
                    pasteboard.string = "\(binConverted)"
                }) {
                    HStack {
                        Text("Copy result")
                        Spacer()
                        Image(systemName: "doc.on.doc")
                    }
                }
            }
            
            // Decimal results section
            Section(header: Text("Decimal conversion")) {
                HStack {
                    Text("Decimal:")
                        .bold()
                    Spacer()
                    Text(String(decConverted))
                        .font(.system(size: 16, design: .monospaced))
                    Button(action: {
                        pasteboard.string = "\(decConverted)"
                    }) {
                        Image(systemName: "doc.on.doc")
                    }.buttonStyle(BorderlessButtonStyle())
                }
            }
            
            // Hexadecimal results section
            Section(header: Text("Hexadecimal conversion")) {
                HStack {
                    Text("Hexadecimal:")
                        .bold()
                    Spacer()
                    Text("0x\(hexConverted.uppercased())")
                        .font(.system(size: 16, design: .monospaced))
                    Button(action: {
                        pasteboard.string = "\(hexConverted)"
                    }) {
                        Image(systemName: "doc.on.doc")
                    }.buttonStyle(BorderlessButtonStyle())
                }
            }
            
            Section(header: Text("Explanation")) {
                Text("This calculator converts integers between their decimal, hexadecimal and binary equivalents. Signed (two's complement) as well as unsigned integers are supported.")
                
            }
        }
        .navigationBarTitle(Text("Number Base Converter"))
    }
    
    
    
    func convertNumberBase() {
        // Need to validate the binary number to check it falls within bounds

        if (inputBase == .dec) {
            let decCheckValue = Int(decNumberIn) ?? 0
            // Condition 1 - decimal, unsigned, if less than -2^31 and greater than (2^31 - 1)
            if (inputSigned == true && (decCheckValue < digitalCalcs.min32BitSigned || decCheckValue > digitalCalcs.max32BitSigned)) {
                decimalCheckFailed = true
                errorHaptics()
                return
            } else if (inputSigned == false && (decCheckValue < 0 || decCheckValue >= digitalCalcs.max32BitUnsigned)) {
                decimalCheckFailed = true
                errorHaptics()
                return
            }
        }
        // Play the success haptic
        successHaptics()
        
        // Case statement for number base
        switch inputBase {
        
        case .bin:
            // First, convert the binary to decimal.
            decConverted = Int(digitalCalcs.binToDec(binNumber: binNumberIn, signed: inputSigned))
            print(decConverted)
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
        binConverted = digitalCalcs.decToBin(decNumber: decConverted, signed: inputSigned, skipValidation: true)
        // Split the binary string
        binarySplit = splitBinary(binaryString: binConverted)
        // Convert the decimal to hexadecimal.
        hexConverted = digitalCalcs.decToHex(decNumber: decConverted, signed: inputSigned, skipValidation: true)
    }
    
    func splitBinary(binaryString: String) -> [String] {
        var stringArray: [String] = []
        for stringIndex in 0...6 {
            print(stringIndex)
            let start = binaryString.index(binaryString.startIndex, offsetBy: 4 * stringIndex)
            let end = binaryString.index(binaryString.startIndex, offsetBy: ((4 * stringIndex) + 4))
            let range = start..<end
            let string = binaryString[range]
            stringArray.append(String(string))
        }
        
        stringArray.append(String(binaryString.suffix(4)))
        return stringArray
    }
    
}

struct NumberBaseCalc_Previews: PreviewProvider {
    static var previews: some View {
        NumberBaseCalc()
    }
}

struct binaryView: View {
    var binarySplit: [String] = []
    var body: some View {
        VStack(alignment: .center) {
            // First row of text (first 4 elements of array corresponding to binary digits 32-17)
            Text("\(binarySplit[0]) \(binarySplit[1]) \(binarySplit[2]) \(binarySplit[3])")
                .font(.system(size: 24, design: .monospaced))
            // Adding ticker marks in a HStack to indicate bits
            HStack {
                Text("31")
                Spacer()
                Text("16")
            }
                .foregroundColor(Color.gray)
                .font(.caption)
            // Second row of text (last 4 elements of array corresponding to binary digits 16-1)
            Text("\(binarySplit[4]) \(binarySplit[5]) \(binarySplit[6]) \(binarySplit[7])")
                .font(.system(size: 24, design: .monospaced))
            HStack {
                Text("15")
                Spacer()
                Text("0")
            }
                .foregroundColor(Color.gray)
                .font(.caption)
        }.frame(width: 290)
    }
    
    
}
