//
//  ResistorCalcs.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import Foundation

// Struct used to store pairs of values and prefixes
struct ComponentValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SIResistorPrefixes // Prefix
}

class ResistorCalcs: ObservableObject {
    
    var siPrefixCalc = SIPrefixCalc()
    var valueTemp: Double = 0.0
    var prefixTemp: SIResistorPrefixes = .Ω
    
    // ComponentValue object to show parallel result
    @Published var parallelCalculated = ComponentValue(id: UUID(), value: 0.0, prefix: .Ω)
    
    // ComponentValue object to show series result
    @Published var seriesCalculated = ComponentValue(id: UUID(), value: 0.0, prefix: .Ω)
    
    // Array of ComponentValue structs to store the resistor data
    @Published var resistorValues: [ComponentValue] = []
    
    // Function for calculating parallel resistors
    func calcParallelResistors(values: [ComponentValue]) -> ComponentValue {
        if (values.count == 0) {
            parallelCalculated = ComponentValue(id: UUID(), value: 0.0, prefix: .Ω)
            return parallelCalculated
        } else {
            var resistanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let resistanceValue: Double = 1.0 / (value.value * pow(10.0, Double(value.prefix.rawValue)))
                resistanceTotal += resistanceValue
            }
            // Take the reciprocal and then normalise to get a ComponentValue
            let resistanceValueReciprocal = 1.0 / resistanceTotal
            let resistanceValueWithPrefix = siPrefixCalc.calcPrefix(value: resistanceValueReciprocal, prefix: .Ω)
            parallelCalculated = resistanceValueWithPrefix
            print(resistanceValueWithPrefix.value)
            return resistanceValueWithPrefix
        }
    }
    
    // Function for calculating series resistors
    func calcSeriesResistors(values: [ComponentValue]) -> ComponentValue {
        if (values.count == 0) {
            seriesCalculated = ComponentValue(id: UUID(), value: 0.0, prefix: .Ω)
            return seriesCalculated
        } else {
            var resistanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let resistanceValue: Double = value.value * pow(10.0, Double(value.prefix.rawValue))
                resistanceTotal += resistanceValue
            }
            // Calculate the value
            let resistanceValueWithPrefix = siPrefixCalc.calcPrefix(value: resistanceTotal, prefix: .Ω)
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
        let newComponentValue = ComponentValue(id: UUID(), value: 0.0, prefix: .Ω)
        print(newComponentValue)
        resistorValues.append(newComponentValue)
    }
    
    // Function to add the temporary element into the array, after running it through prefix calculation to normalise it
    func addTempElement() {
        print("Temp value = \(valueTemp)")
        let normalisedTempElement = siPrefixCalc.calcPrefix(value: valueTemp, prefix: prefixTemp)
        let newComponentValue = ComponentValue(id: UUID(), value: normalisedTempElement.value, prefix: normalisedTempElement.prefix)
        print(newComponentValue)
        resistorValues.append(newComponentValue)
    }
}
