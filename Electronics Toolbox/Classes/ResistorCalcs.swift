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
    var prefixTemp: SIPrefixes = .none
    
    // SIValue object to show parallel result
    @Published var parallelCalculated = SIValue(id: UUID(), value: 0.0, prefix: .none)
    
    // SIValue object to show series result
    @Published var seriesCalculated = SIValue(id: UUID(), value: 0.0, prefix: .none)
    
    // Array of SIValue structs to store the resistor data
    @Published var resistorValues: [SIValue] = []
    
    // Number of bands in resistor
    @Published var numberOfBands: NumberOfResistorBands = .four
    // Band variables
    @Published var bandDigit1: ResistorColourCode = .black
    @Published var bandDigit2: ResistorColourCode = .black
    @Published var bandDigit3: ResistorColourCode = .black
    @Published var multiplier: ResistorMultiplier = .black
    @Published var tolerance: ResistorTolerance = .silver
    
    // SIValue for calculated resistor from colour code
    @Published var colourCodeResistor = SIValue(id: UUID(), value: 0.0, prefix: .none)
    @Published var ccResistorLowerTolerance = SIValue(id: UUID(), value: 0.0, prefix: .none)
    @Published var ccResistorUpperTolerance = SIValue(id: UUID(), value: 0.0, prefix: .none)
    
    // Tolerance lookup array for calculations
    private var toleranceLookupArray: [Double] = [0.2, 0.1, 0.05, 0.01, 0.02, 0.005, 0.0025, 0.001, 0.0005]
    
    // Function for calculating parallel resistors
    func calcParallelResistors(values: [SIValue]) -> SIValue {
        if (values.count == 0) {
            parallelCalculated = SIValue(id: UUID(), value: 0.0, prefix: .none)
            return parallelCalculated
        } else {
            var resistanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let resistanceValue: Double = 1.0 / (value.value * pow(10.0, Double(value.prefix.rawValue)))
                resistanceTotal += resistanceValue
            }
            // Take the reciprocal and then normalise to get a SIValue
            let resistanceValueReciprocal = 1.0 / resistanceTotal
            let resistanceValueWithPrefix = siPrefixCalc.calcSIPrefix(value: resistanceValueReciprocal, prefix: .none)
            parallelCalculated = resistanceValueWithPrefix
            print(resistanceValueWithPrefix.value)
            return resistanceValueWithPrefix
        }
    }
    
    // Function for calculating series resistors
    func calcSeriesResistors(values: [SIValue]) -> SIValue {
        if (values.count == 0) {
            seriesCalculated = SIValue(id: UUID(), value: 0.0, prefix: .none)
            return seriesCalculated
        } else {
            var resistanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let resistanceValue: Double = value.value * pow(10.0, Double(value.prefix.rawValue))
                resistanceTotal += resistanceValue
            }
            // Calculate the value
            let resistanceValueWithPrefix = siPrefixCalc.calcSIPrefix(value: resistanceTotal, prefix: .none)
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
        let newResistorValue = SIValue(id: UUID(), value: 0.0, prefix: .none)
        print(newResistorValue)
        resistorValues.append(newResistorValue)
    }
    
    // Function to add the temporary element into the array, after running it through prefix calculation to normalise it
    func addTempElement() {
        print("Temp value = \(valueTemp)")
        let normalisedTempElement = siPrefixCalc.calcSIPrefix(value: valueTemp, prefix: prefixTemp)
        let newResistorValue = SIValue(id: UUID(), value: normalisedTempElement.value, prefix: normalisedTempElement.prefix)
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
            colourCodeResistor = siPrefixCalc.calcSIPrefix(value: bandValue, prefix: .none)
            print(colourCodeResistor)
            // Calculate the upper and lower tolerance
            ccResistorUpperTolerance = siPrefixCalc.calcSIPrefix(value: bandValue * (1.0 + toleranceLookupArray[tolerance.rawValue]), prefix: .none)
            ccResistorLowerTolerance = siPrefixCalc.calcSIPrefix(value: bandValue * (1.0 - toleranceLookupArray[tolerance.rawValue]), prefix: .none)
        }
    }
    
    // Function to calculate an LED current limiting resistor
    func calcLEDResistor(supplyVoltage: Double, ledVoltage: Double, ledCurrent: Double) -> SIValue {
        let resistorValue: Double = (supplyVoltage - ledVoltage) / ledCurrent
        // Calculate the resistor value with the prefix
        let resistorValueWithPrefix = siPrefixCalc.calcSIPrefix(value: resistorValue, prefix: .none)
        // Return this value
        print(resistorValueWithPrefix)
        return resistorValueWithPrefix
    }
    
    // Function to calculate the potential divider voltage across R2 (bottom resistor of a network)
    func calcPotentialDividerVoltage(supplyVoltage: Double, r1: SIValue, r2: SIValue) -> Double {
        // Get rid of the prefixes for R1 and R2
        let r1NoPrefix = r1.value * pow(10.0, Double(r1.prefix.rawValue))
        let r2NoPrefix = r2.value * pow(10.0, Double(r2.prefix.rawValue))
        let voltageOut = (supplyVoltage * r2NoPrefix) / (r1NoPrefix + r2NoPrefix)
        return voltageOut
    }
}
