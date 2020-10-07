//
//  CapacitorCalcs.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 28/08/2020.
//

import Foundation

class CapacitorCalcs: ObservableObject {
    
    var siPrefixCalc = SIPrefixCalc()
    var valueTemp: Double = 0.0
    var valueTempString: String = "0"
    var prefixTemp: SIPrefixes = .none
    
    // CapacitorValue object to show parallel result
    @Published var parallelCalculated = SIValue(id: UUID(), value: 0.0, prefix: .none)
    
    // CapacitorValue object to show series result
    @Published var seriesCalculated = SIValue(id: UUID(), value: 0.0, prefix: .none)
    
    // Array of CapacitorValues
    @Published var capacitorValues: [SIValue] = []
    
    // Function for calculating series capacitors resistors
    func calcSeriesCapacitors(values: [SIValue]) -> SIValue {
        if (values.count == 0) {
            parallelCalculated = SIValue(id: UUID(), value: 0.0, prefix: .none)
            return parallelCalculated
        } else {
            var capacitanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let capacitanceValue: Double = 1.0 / (value.value * pow(10.0, Double(value.prefix.rawValue)))
                capacitanceTotal += capacitanceValue
            }
            // Take the reciprocal and then normalise to get a SIValue
            let capacitanceValueReciprocal = 1.0 / capacitanceTotal
            let capacitanceValueWithPrefix = siPrefixCalc.calcSIPrefix(value: capacitanceValueReciprocal, prefix: .none)
            seriesCalculated = capacitanceValueWithPrefix
            print(capacitanceValueWithPrefix.value)
            return capacitanceValueWithPrefix
        }
    }
    
    // Function for calculating parallel capacitors
    func calcParallelCapacitors(values: [SIValue]) -> SIValue {
        if (values.count == 0) {
            seriesCalculated = SIValue(id: UUID(), value: 0.0, prefix: .none)
            return seriesCalculated
        } else {
            var capacitanceTotal: Double = 0
            // Iterate through the array and add the resistor values to the total
            for value in values {
                let capacitanceValue: Double = value.value * pow(10.0, Double(value.prefix.rawValue))
                capacitanceTotal += capacitanceValue
            }
            // Calculate the value
            let capacitanceValueWithPrefix = siPrefixCalc.calcSIPrefix(value: capacitanceTotal, prefix: .none)
            parallelCalculated = capacitanceValueWithPrefix
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
        let newCapacitorValue = SIValue(id: UUID(), value: 0.0, prefix: .none)
        print(newCapacitorValue)
        capacitorValues.append(newCapacitorValue)
    }
    
    // Function to add the temporary element into the array, after running it through prefix calculation to normalise it
    func addTempElement() {
        print("Temp value = \(valueTemp)")
        let normalisedTempElement = siPrefixCalc.calcSIPrefix(value: valueTemp, prefix: prefixTemp)
        let newCapacitorValue = SIValue(id: UUID(), value: normalisedTempElement.value, prefix: normalisedTempElement.prefix)
        print(newCapacitorValue)
        capacitorValues.append(newCapacitorValue)
    }
    
}
