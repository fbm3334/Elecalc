//
//  SIPrefixCalc.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import Foundation

class SIPrefixCalc {
    
    // Function for calculating the correct prefix
    func calcPrefix(value: Double, prefix: SIPrefix) -> ComponentValue {
        // Create the ComponentValue variable as an optional
        var calcValue = ComponentValue(id: UUID(), value: 0.0, prefix: .none)
        // Calculate the base 10 logarithm of the value multiplied by the initial prefix
        let prefixPower: Double = pow(10.0, Double(prefix.rawValue))
        print("Prefix power = \(prefixPower), Value = \(value)")
        let valueLog = log10(value * prefixPower)
        print(valueLog)
        // Calculate the multiple of 3 of the logarithm (as SI prefixes are in multiples of 3)
        let calculatedPrefix = SIPrefix(rawValue: Int(valueLog / 3) * 3)
        // Print the value for debug purposes
        print(calculatedPrefix!.rawValue)
        // Calculate the new power of ten (this is used to shift the decimal point)
        let powerOfTen = pow(10.0, Double(calculatedPrefix!.rawValue))
        print(powerOfTen)
        // Put the correct values into calcValue and return
        calcValue.value = Double(value) / powerOfTen
        calcValue.prefix = calculatedPrefix!
        return calcValue
    }
}
