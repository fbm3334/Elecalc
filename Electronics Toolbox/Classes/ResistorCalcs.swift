//
//  ResistorCalcs.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import Foundation

class ResistorCalcs: ObservableObject {
    
    var siPrefixCalc = SIPrefixCalc()
    var valueTempString: String = "0"
    var valueTemp: Double = 0.0
    var prefixTemp: SIResistorPrefixes = .Ω
    
    // ResistorValue object to show parallel result
    @Published var parallelCalculated = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
    
    // ResistorValue object to show series result
    @Published var seriesCalculated = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
    
    // Array of ResistorValue structs to store the resistor data
    @Published var resistorValues: [ResistorValue] = []
    
    // Number of bands in resistor
    @Published var numberOfBands: NumberOfResistorBands = .four
    // Band variables
    @Published var bandDigit1: ResistorColourCode = .black
    @Published var bandDigit2: ResistorColourCode = .black
    @Published var bandDigit3: ResistorColourCode = .black
    @Published var multiplier: ResistorMultiplier = .black
    @Published var tolerance: ResistorTolerance = .silver
    
    // ResistorValue for calculated resistor from colour code
    @Published var colourCodeResistor = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
    @Published var ccResistorLowerTolerance = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
    @Published var ccResistorUpperTolerance = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
    
    // Function for calculating parallel resistors
    func calcParallelResistors(values: [ResistorValue]) -> ResistorValue {
        if (values.count == 0) {
            parallelCalculated = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
            return parallelCalculated
        } else {
            var resistanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let resistanceValue: Double = 1.0 / (value.value * pow(10.0, Double(value.prefix.rawValue)))
                resistanceTotal += resistanceValue
            }
            // Take the reciprocal and then normalise to get a ResistorValue
            let resistanceValueReciprocal = 1.0 / resistanceTotal
            let resistanceValueWithPrefix = siPrefixCalc.calcResistorPrefix(value: resistanceValueReciprocal, prefix: .Ω)
            parallelCalculated = resistanceValueWithPrefix
            print(resistanceValueWithPrefix.value)
            return resistanceValueWithPrefix
        }
    }
    
    // Function for calculating series resistors
    func calcSeriesResistors(values: [ResistorValue]) -> ResistorValue {
        if (values.count == 0) {
            seriesCalculated = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
            return seriesCalculated
        } else {
            var resistanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let resistanceValue: Double = value.value * pow(10.0, Double(value.prefix.rawValue))
                resistanceTotal += resistanceValue
            }
            // Calculate the value
            let resistanceValueWithPrefix = siPrefixCalc.calcResistorPrefix(value: resistanceTotal, prefix: .Ω)
            seriesCalculated = resistanceValueWithPrefix
            print(resistanceValueWithPrefix.value)
            return resistanceValueWithPrefix
        }
    }
    
    // Function to initialise/reset the array
    func resetArray() {
        resistorValues = []
        // For loop between 1 and 2
        for _ in 1...2 {
            addToArray()
        }
        
    }
    
    // Function to add element to array
    func addToArray() {
        let newResistorValue = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
        print(newResistorValue)
        resistorValues.append(newResistorValue)
    }
    
    // Function to add the temporary element into the array, after running it through prefix calculation to normalise it
    func addTempElement() {
        print("Temp value = \(valueTemp)")
        let normalisedTempElement = siPrefixCalc.calcResistorPrefix(value: valueTemp, prefix: prefixTemp)
        let newResistorValue = ResistorValue(id: UUID(), value: normalisedTempElement.value, prefix: normalisedTempElement.prefix)
        print(newResistorValue)
        resistorValues.append(newResistorValue)
    }
    
    // Function to calculate resistor value from the colour code
    func calcResistorValuefromColourCode() {
        var bandValue: Double = 0
        // If it is a 4 band resistor, then multiply the first band by 10 and add the second
        if (numberOfBands == .four) {
            bandValue = Double((bandDigit1.rawValue * 10) + bandDigit2.rawValue)
        } else {
        // If it is a 5 band resistor, then (100 x first band + 10 x second band + third band)
            bandValue = Double((bandDigit1.rawValue * 100) + (bandDigit2.rawValue * 10) + bandDigit3.rawValue)
        }
        
        // Multiply the resistor value by the multiplier
        bandValue *= pow(10.0, Double(multiplier.rawValue))
        
        // Calculate the prefix to get the resistor value
        if bandValue != 0 {
            colourCodeResistor = siPrefixCalc.calcResistorPrefix(value: bandValue, prefix: .Ω)
            print(colourCodeResistor)
            // Calculate the upper and lower tolerance
            ccResistorUpperTolerance = siPrefixCalc.calcResistorPrefix(value: bandValue * (1.0 + tolerance.rawValue), prefix: .Ω)
            ccResistorLowerTolerance = siPrefixCalc.calcResistorPrefix(value: bandValue * (1.0 - tolerance.rawValue), prefix: .Ω)
        }
    }
    
    // Function to calculate an LED current limiting resistor
    func calcLEDResistor(supplyVoltage: Double, ledVoltage: Double, ledCurrent: Double) -> ResistorValue {
        let resistorValue: Double = (supplyVoltage - ledVoltage) / ledCurrent
        // Calculate the resistor value with the prefix
        let resistorValueWithPrefix = siPrefixCalc.calcResistorPrefix(value: resistorValue, prefix: .Ω)
        // Return this value
        print(resistorValueWithPrefix)
        return resistorValueWithPrefix
    }
    
    // Function to calculate the potential divider voltage across R2 (bottom resistor of a network)
    func calcPotentialDividerVoltage(supplyVoltage: Double, r1: ResistorValue, r2: ResistorValue) -> Double {
        // Get rid of the prefixes for R1 and R2
        let r1NoPrefix = r1.value * pow(10.0, Double(r1.prefix.rawValue))
        let r2NoPrefix = r2.value * pow(10.0, Double(r2.prefix.rawValue))
        let voltageOut = (supplyVoltage * r2NoPrefix) / (r1NoPrefix + r2NoPrefix)
        return voltageOut
    }
}
