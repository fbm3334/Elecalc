//
//  GainCalcs.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 17/09/2020.
//

import Foundation

// Class for gain calculations
class GainCalcs: ObservableObject {
    // Function to convert decibel to numeric gain
    func decibelToNumericGain(dBGain: Double, gainType: DecibelGains) -> Double {
        let gainPower = dBGain / Double(gainType.rawValue)
        return pow(10.0, gainPower)
    }
    
    // Function to convert numeric to decibel gain
    func numericToDecibelGain(numericGain: Double, gainType: DecibelGains) -> Double {
        return (Double(gainType.rawValue) * log10(numericGain))
    }
}
