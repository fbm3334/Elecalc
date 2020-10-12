//
//  UnitCalcs.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 27/09/2020.
//

import Foundation

// Class for simple unit calculations
class UnitCalcs: ObservableObject {
    var siPrefixCalc = SIPrefixCalc()
    
    // Function to calculate voltage
    func calcVoltage(current: SIValue, resistance: SIValue) -> SIValue {
        // V = IR
        let currentNormalised = current.value * pow(10.0, Double(current.prefix.rawValue))
        let resistanceNormalised = resistance.value * pow(10.0, Double(resistance.prefix.rawValue))
        let voltageNormalised = currentNormalised * resistanceNormalised
        return siPrefixCalc.calcSIPrefix(value: voltageNormalised, prefix: .none)
    }
    
    // Function to calculate current
    func calcCurrent(voltage: SIValue, resistance: SIValue) -> SIValue {
        // I = V/R
        let voltageNormalised = voltage.value * pow(10.0, Double(voltage.prefix.rawValue))
        let resistanceNormalised = resistance.value * pow(10.0, Double(resistance.prefix.rawValue))
        let currentNormalised = voltageNormalised / resistanceNormalised
        return siPrefixCalc.calcSIPrefix(value: currentNormalised, prefix: .none)
    }
    
    // Function to calculate resistance
    func calcResistance(voltage: SIValue, current: SIValue) -> SIValue {
        let voltageNormalised = voltage.value * pow(10.0, Double(voltage.prefix.rawValue))
        let currentNormalised = current.value * pow(10.0, Double(current.prefix.rawValue))
        let resistanceNormalised = voltageNormalised / currentNormalised
        return siPrefixCalc.calcSIPrefix(value: resistanceNormalised, prefix: .none)
    }
    
    // Function to calculate power from current and voltage
    func calcPowerCurrentVoltage(voltage: SIValue, current: SIValue) -> SIValue {
        let voltageNormalised = voltage.value * pow(10.0, Double(voltage.prefix.rawValue))
        let currentNormalised = current.value * pow(10.0, Double(current.prefix.rawValue))
        let powerNormalised = voltageNormalised * currentNormalised
        return siPrefixCalc.calcSIPrefix(value: powerNormalised, prefix: .none)
    }
    
    // Function to calculate power from current and resistance
    func calcPowerCurrentResistance(current: SIValue, resistance: SIValue) -> SIValue {
        let currentNormalised = current.value * pow(10.0, Double(current.prefix.rawValue))
        let resistanceNormalised = resistance.value * pow(10.0, Double(resistance.prefix.rawValue))
        let powerNormalised = currentNormalised * currentNormalised * resistanceNormalised
        return siPrefixCalc.calcSIPrefix(value: powerNormalised, prefix: .none)
    }
    
    // Function to calculate power from voltage and resistance
    func calcPowerVoltageResistance(voltage: SIValue, resistance: SIValue) -> SIValue {
        let voltageNormalised = voltage.value * pow(10.0, Double(voltage.prefix.rawValue))
        let resistanceNormalised = resistance.value * pow(10.0, Double(resistance.prefix.rawValue))
        let powerNormalised = voltageNormalised * voltageNormalised * resistanceNormalised
        return siPrefixCalc.calcSIPrefix(value: powerNormalised, prefix: .none)
    }
}
