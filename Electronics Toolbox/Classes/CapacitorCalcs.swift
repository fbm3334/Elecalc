//
//  CapacitorCalcs.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 28/08/2020.
//

import Foundation

// Capacitor values struct
struct CapacitorValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SICapacitorPrefixes // Prefix
}

class CapacitorCalcs: ObservableObject {
    
    var siPrefixCalc = SIPrefixCalc()
    var valueTemp: Double = 0.0
    var prefixTemp: SICapacitorPrefixes = .F
    
    // CapacitorValue object to show parallel result
    @Published var parallelCalculated = CapacitorValue(id: UUID(), value: 0.0, prefix: .F)
    
    // CapacitorValue object to show series result
    @Published var seriesCalculated = CapacitorValue(id: UUID(), value: 0.0, prefix: .F)
    
    // Array of CapacitorValues
    @Published var capacitorValues: [CapacitorValue] = []
    
    // Function for calculating series capacitors resistors
    func calcSeriesCapacitors(values: [CapacitorValue]) -> CapacitorValue {
        if (values.count == 0) {
            parallelCalculated = CapacitorValue(id: UUID(), value: 0.0, prefix: .F)
            return parallelCalculated
        } else {
            var capacitanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let capacitanceValue: Double = 1.0 / (value.value * pow(10.0, Double(value.prefix.rawValue)))
                capacitanceTotal += capacitanceValue
            }
            // Take the reciprocal and then normalise to get a ResistorValue
            let capacitanceValueReciprocal = 1.0 / capacitanceTotal
            let capacitanceValueWithPrefix = siPrefixCalc.calcCapacitorPrefix(value: capacitanceValueReciprocal, prefix: .F)
            parallelCalculated = capacitanceValueWithPrefix
            print(capacitanceValueWithPrefix.value)
            return capacitanceValueWithPrefix
        }
    }
    
    // Function for calculating parallel capacitors
    func calcParallelCapacitors(values: [CapacitorValue]) -> CapacitorValue {
        if (values.count == 0) {
            seriesCalculated = CapacitorValue(id: UUID(), value: 0.0, prefix: .F)
            return seriesCalculated
        } else {
            var capacitanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let capacitanceValue: Double = value.value * pow(10.0, Double(value.prefix.rawValue))
                capacitanceTotal += capacitanceValue
            }
            // Calculate the value
            let capacitanceValueWithPrefix = siPrefixCalc.calcCapacitorPrefix(value: capacitanceTotal, prefix: .F)
            seriesCalculated = capacitanceValueWithPrefix
            print(capacitanceValueWithPrefix.value)
            return capacitanceValueWithPrefix
        }
    }
    
    // Function to initialise/reset the array
    func resetArray() {
        capacitorValues = []
        // For loop between 1 and 2
        for _ in 1...2 {
            addToArray()
        }
        
    }
    
    // Function to add element to array
    func addToArray() {
        let newCapacitorValue = CapacitorValue(id: UUID(), value: 0.0, prefix: .F)
        print(newCapacitorValue)
        capacitorValues.append(newCapacitorValue)
    }
    
    // Function to add the temporary element into the array, after running it through prefix calculation to normalise it
    func addTempElement() {
        print("Temp value = \(valueTemp)")
        let normalisedTempElement = siPrefixCalc.calcCapacitorPrefix(value: valueTemp, prefix: prefixTemp)
        let newCapacitorValue = CapacitorValue(id: UUID(), value: normalisedTempElement.value, prefix: normalisedTempElement.prefix)
        print(newCapacitorValue)
        capacitorValues.append(newCapacitorValue)
    }
    
}
