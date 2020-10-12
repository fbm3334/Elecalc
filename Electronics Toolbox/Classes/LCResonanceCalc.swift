//
//  LCResonanceCalc.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 07/10/2020.
//

import Foundation

// Class used to calculate the LC resonant frequency
class LCResonanceCalc: ObservableObject {
    var siPrefixCalc = SIPrefixCalc()
    
    // Function to calculate the LC resonant frequency
    func calcLCResFreq(inductance: SIValue, capacitance: SIValue) -> SIValue {
        // Calc the internal inductance and capacitance
        let inductanceInt = inductance.value * pow(10.0, Double(inductance.prefix.rawValue))
        let capacitanceInt = capacitance.value * pow(10.0, Double(capacitance.prefix.rawValue))
        // Calculate the frequency in Hz
        let freq = 1.0 / (2 * Double.pi * sqrt(inductanceInt * capacitanceInt))
        print(freq)
        // Return the frequency
        return siPrefixCalc.calcSIPrefix(value: freq, prefix: .none)
    }
}
