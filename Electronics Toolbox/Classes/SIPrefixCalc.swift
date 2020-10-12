//
//  SIPrefixCalc.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import Foundation

class SIPrefixCalc {
    
    // Function for calculating the correct resistor prefix
    func calcSIPrefix(value: Double, prefix: SIPrefixes) -> SIValue {
        print("Prefix passed = \(prefix)")
        // Create the calculated value variable as a ComponentValue
        var calcValue = SIValue(id: UUID(), value: 0.0, prefix: .none)
        // Calculate 10 ^ initial prefix
        let prefixPower: Double = pow(10.0, Double(prefix.rawValue))
        print("Prefix power = \(prefixPower), Value = \(value)")
        // Run the CalcPrefixValue function
        let calculatedPrefixValue = calcPrefixValue(prefixPower: prefixPower, value: value, maxValue: SIPrefixes.G.rawValue, minValue: SIPrefixes.p.rawValue)
        
        // Calculate the multiple of 3 of the logarithm (as SI prefixes are in multiples of 3)
        let calculatedPrefix = SIPrefixes(rawValue: calculatedPrefixValue)
        // Print the value for debug purposes
        print(calculatedPrefix!.rawValue)
        // Calculate the new power of ten (this is used to shift the decimal point)
        let powerOfTen = pow(10.0, Double(calculatedPrefix!.rawValue))
        print(powerOfTen)
        // Put the correct values into calcValue and return
        calcValue.value = Double(value * prefixPower) / powerOfTen
        print(calcValue.value)
        calcValue.prefix = calculatedPrefix!
        return calcValue
    }
    
    // Function to calculate the correct prefix - it will also add a floor to the value so that the min/max enum values are not exceeded
    func calcPrefixValue(prefixPower: Double, value: Double, maxValue: Int, minValue: Int) -> Int {
        // Calculate the base 10 logarithm of the value multiplied by the power of 10
        let valueLog = log10(value * prefixPower)
        print(valueLog)
        // Decide on which rounding function to use
        var roundedLog: Int = 0
        if (valueLog < 0) {
            roundedLog = roundDownNegative(logValue: valueLog)
        } else {
            roundedLog = roundDownPositive(logValue: valueLog)
        }
        // Normalise the values so they cannot exceed or go lower than the limits
        if (roundedLog < minValue) {
            roundedLog = minValue
        } else if (roundedLog > maxValue) {
            roundedLog = maxValue
        }
        return roundedLog
    }
    
    // Function for rounding negative numbers down to the next lowest power of 10 (SI)
    // For example, a result with a valueLog of -3.2 would round down to -6.
    func roundDownNegative(logValue: Double) -> Int {
        // Take the absolute value of the logValue
        let logValuePositive = abs(logValue)
        // Calculate the modulus of the number divided by 3
        let fractionNum: Double = logValuePositive / 3.0
        let roundedNum: Int = Int(ceil(fractionNum))
        return -(roundedNum * 3)
    }
    
    // Function for rounding positive numbers down to the next lowest power of 10 (SI)
    func roundDownPositive(logValue: Double) -> Int {
        let roundedNum: Int = Int(logValue / 3) * 3
        return roundedNum
    }
}
