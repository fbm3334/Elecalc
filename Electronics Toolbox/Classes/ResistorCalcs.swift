//
//  ResistorCalcs.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import Foundation

// Struct used to store pairs of values and prefixes
struct ResistorValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SIResistorPrefixes // Prefix
}

class ResistorCalcs: ObservableObject {
    
    var siPrefixCalc = SIPrefixCalc()
    var valueTemp: Double = 0.0
    var prefixTemp: SIResistorPrefixes = .Ω
    
    // ResistorValue object to show parallel result
    @Published var parallelCalculated = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
    
    // ResistorValue object to show series result
    @Published var seriesCalculated = ResistorValue(id: UUID(), value: 0.0, prefix: .Ω)
    
    // Array of ResistorValue structs to store the resistor data
    @Published var resistorValues: [ResistorValue] = []
    
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
}
