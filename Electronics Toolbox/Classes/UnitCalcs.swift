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
    func calcVoltage(current: CurrentValue, resistance: ResistorValue) -> VoltageValue {
        // V = IR
        let currentNormalised = current.value * pow(10.0, Double(current.prefix.rawValue))
        let resistanceNormalised = resistance.value * pow(10.0, Double(resistance.prefix.rawValue))
        let voltageNormalised = currentNormalised * resistanceNormalised
        return siPrefixCalc.calcVoltagePrefix(value: voltageNormalised, prefix: .V)
    }
    
    // Function to calculate current
    func calcCurrent(voltage: VoltageValue, resistance: ResistorValue) -> CurrentValue {
        // I = V/R
        let voltageNormalised = voltage.value * pow(10.0, Double(voltage.prefix.rawValue))
        let resistanceNormalised = resistance.value * pow(10.0, Double(resistance.prefix.rawValue))
        let currentNormalised = voltageNormalised / resistanceNormalised
        return siPrefixCalc.calcCurrentPrefix(value: currentNormalised, prefix: .A)
    }
    
    // Function to calculate resistance
    func calcResistance(voltage: VoltageValue, current: CurrentValue) -> ResistorValue {
        let voltageNormalised = voltage.value * pow(10.0, Double(voltage.prefix.rawValue))
        let currentNormalised = current.value * pow(10.0, Double(current.prefix.rawValue))
        let resistanceNormalised = voltageNormalised / currentNormalised
        return siPrefixCalc.calcResistorPrefix(value: resistanceNormalised, prefix: .Ω)
    }
    
    // Function to calculate power from current and voltage
    func calcPowerCurrentVoltage(voltage: VoltageValue, current: CurrentValue) -> PowerValue {
        let voltageNormalised = voltage.value * pow(10.0, Double(voltage.prefix.rawValue))
        let currentNormalised = current.value * pow(10.0, Double(current.prefix.rawValue))
        let powerNormalised = voltageNormalised * currentNormalised
        return siPrefixCalc.calcPowerPrefix(value: powerNormalised, prefix: .W)
    }
    
    // Function to calculate power from current and resistance
    func calcPowerCurrentResistance(current: CurrentValue, resistance: ResistorValue) -> PowerValue {
        let currentNormalised = current.value * pow(10.0, Double(current.prefix.rawValue))
        let resistanceNormalised = resistance.value * pow(10.0, Double(resistance.prefix.rawValue))
        let powerNormalised = currentNormalised * currentNormalised * resistanceNormalised
        return siPrefixCalc.calcPowerPrefix(value: powerNormalised, prefix: .W)
    }
    
    // Function to calculate power from voltage and resistance
    func calcPowerVoltageResistance(voltage: VoltageValue, resistance: ResistorValue) -> PowerValue {
        let voltageNormalised = voltage.value * pow(10.0, Double(voltage.prefix.rawValue))
        let resistanceNormalised = resistance.value * pow(10.0, Double(resistance.prefix.rawValue))
        let powerNormalised = voltageNormalised * voltageNormalised * resistanceNormalised
        return siPrefixCalc.calcPowerPrefix(value: powerNormalised, prefix: .W)
    }
}
