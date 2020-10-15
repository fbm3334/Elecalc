//
//  DigitalCalcs.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 09/10/2020.
//

import Foundation

enum NumberBase: Int, CustomStringConvertible, CaseIterable {
    case bin, dec, hex
    
    var description: String {
        switch self {
        case .bin: return "Bin (2)"
        case .dec: return "Dec (10)"
        case .hex: return "Hex (16)"
        }
    }
}

// Class for digital calculations
class DigitalCalcs: ObservableObject {
    // Let declarations for min/max boundaries
    let min32BitSigned = -2147483648
    let max32BitSigned = 2147483647
    let max32BitUnsigned = 4294967296
    
    // Let declarations for allowed characters for each of the types
    let binAllowedCharacters = "01"
    let decAllowedCharacters = "0123456789-"
    let hexAllowedCharacters = "0123456789ABCDEFabcdef" // Include the lower case values
    
    // All operations are first done in decimal, and then conversion to hex, bin and oct are done from there.
    // Limited to 32 bits
    
    // Function to convert a decimal number to a binary number.
    func decToBin(decNumber: Int, signed: Bool, skipValidation: Bool) -> String {
        // Validate the decimal number first, return the string "Err" if invalid
        if (validateDec(decNumber: decNumber, signed: signed) == false && skipValidation == false) { return "Err" }
        else {
            // Unsigned
            // If the number is unsigned or >= 0, then calculate the positive number
            if (signed == false || (decNumber >> 31) == 0) {
                let binString = String(decNumber, radix: 2)
                print(binString.count)
                let zeroString = String(repeating: "0", count: 32 - binString.count)
                return zeroString + binString
            } else {
                //let twosComplement = max32BitUnsigned + decNumber
                // XOR the decimal number with 2^32 - 1, and then add one to the result
                let decNumberNegative = abs(decNumber + 1) ^ (max32BitUnsigned - 1)
                let signedBinString = String(decNumberNegative, radix: 2).replacingOccurrences(of: "-", with: "") // Strip away the negative signs
                print("\(signedBinString), count: \(signedBinString.count)")
                let oneString = String(repeating: "1", count: 32 - signedBinString.count)
                return oneString + signedBinString
            }
        }
    }
    
    // Function to convert a decimal number to an hexadecimal number.
    func decToHex(decNumber: Int, signed: Bool, skipValidation: Bool) -> String {
        // Validate the decimal number first, return the string "Err" if invalid
        if (validateDec(decNumber: decNumber, signed: signed) == false && skipValidation == false) { return "Err" }
        else {
            // Unsigned
            // If the number is unsigned or >= 0, then calculate the positive number
            if (signed == false || decNumber >= 0) {
                return String(decNumber, radix: 16)
            } else {
                let twosComplement = max32BitUnsigned + decNumber
                let signedHexString = String(twosComplement, radix: 16)
                let FString = String(repeating: "F", count: 8 - signedHexString.count)
                return (FString + signedHexString).uppercased()
            }
        }
    }
    
    // Function to convert a binary number to a decimal number.
    func binToDec(binNumber: String, signed: Bool) -> Int {
        // Firstly, treat as an unsigned value
        let unsignedDec = UInt(binNumber, radix: 2) ?? 0
        // If the value is unsigned or the MSB is zero, then return the unsigned value
        if (signed == false || binNumber.prefix(1) == "0") {
            return Int(unsignedDec)
        } else {
            return Int(unsignedDec) - max32BitUnsigned
        }
        
    }
    
    
    // Function to convert a hexadecimal number to a decimal number.
    func hexToDec(hexNumber: String, signed: Bool) -> Int {
        let decNumber = Int(hexNumber, radix: 16) ?? 0
        
        // If the number is unsigned or is not negative, convert as usual.
        if (signed == false) {
            return decNumber
        } else {
            // Check the MSB to see if it the number is negative
            let numberNegative = decNumber >> 31
            print("Number negative: \(numberNegative)")
            if (numberNegative == 1) {
                // Take the complement by XORing decNumber with 2^32
                let decNumberComplement = decNumber - max32BitUnsigned
                print("Complement = \(decNumberComplement)")
                return decNumberComplement
            } else {
                return decNumber
            }
        }
    }
    
    // Function to validate the decimal number to check whether it fits within the 32 bit range
    // Returns true if validated correctly, false otherwise.
    func validateDec(decNumber: Int, signed: Bool) -> Bool {
        print("\(decNumber), \(signed)")
        // If it is a signed number, then it needs to be between -2^31 and (2^31 - 1).
        if (signed == true) {
            if (decNumber < min32BitSigned || decNumber > max32BitSigned) { return false }
            else { return true }
        } else {
            // If unsigned, must be between 0 and max 32 bit unsigned value.
            if (decNumber < 0 || decNumber >= max32BitUnsigned) { return false }
            else { return true }
        }
    }
    
    // Function to autofill the text field (for hexadecimal or binary)
    func autoFill(field: String, base: NumberBase) -> String {
        // Check length of string - if zero, return nil
        if (field.count == 0) {
            return ""
        }
        // Work out what the prefix should be from the first character
        let fillPrefix = Array(field)[0];
        var fillString: String = ""
        // From the base, work out the max length left
        if (base == .bin) {
            fillString = String(repeating: fillPrefix, count: 32 - field.count)
        } else {
            fillString = String(repeating: fillPrefix, count: 8 - field.count)
        }
        
        return fillString + field
    }
    
    // Function to autofill the text field to the right (for hexadecimal or binary)
    func autoFillRight(field: String, base: NumberBase) -> String {
        // Check length of string - if zero, return nil
        if (field.count == 0) {
            return ""
        }
        // Work out what the prefix should be from the first character
        let fillPrefix = Array(field)[field.count - 1];
        var fillString: String = ""
        // From the base, work out the max length left
        if (base == .bin) {
            fillString = String(repeating: fillPrefix, count: 32 - field.count)
        } else {
            fillString = String(repeating: fillPrefix, count: 8 - field.count)
        }
        
        return field + fillString
    }
    
}
