//
//  ThermalCalcs.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 07/09/2020.
//

import Foundation

// ThermalCalcs class - used for calculating thermal resistance

class ThermalCalcs: ObservableObject {
    
    // Ambient temperature
    var ambientTemperature: Double = 0.0
    var ambientTemperatureString: String = "0"
    
    // Maximum allowable temperature
    var maxAllowableTemperature: Double = 0.0
    var maxAllowableTemperatureString: String = "0"
    
    // Power dissipated by device
    var powerDissipated: Double = 0.0
    var powerDissipatedString: String = "0"
    
    // Junction to case thermal resistance
    var thermalResistanceJuncToCase: Double = 0.0
    var thermalResistanceJuncToCaseString: String = "0"
    
    // Junction to ambient thermal resistance
    var thermalResistanceJuncToAmb: Double = 0.0
    var thermalResistanceJuncToAmbString: String = "0"
    
    // Heatsink thermal resistance
    @Published var heatsinkThermalResistance: Double = 0.0
    
    // Error flags - used to display user errors
    @Published var ambientHigherThanMax: Bool = false // Ambient higher than max
    @Published var negativePowerDissipated: Bool = false // Zero or negative power dissipated
    @Published var negativeThermalResistance: Bool = false // Zero or negative thermal resistance
    @Published var negativeHeatsinkThermalResistance: Bool = false // Zero or negative heatsink thermal resistance (i.e. heatsink will not be capable of cooling device)
    
    // Status flags
    @Published var noHeatsinkRequired: Bool = false
    
    // Function to calculate whether a heatsink is required, or if none is required
    func calcHeatsinkRequirement() {
        // Thermal delta (max allowable - ambient) - if this is less than or equal to zero, then do not calculate
        let tempDelta = maxAllowableTemperature - ambientTemperature
        if (tempDelta <= 0) {
            ambientHigherThanMax = true
            return
        }
        if (validatePowerThermalResistance() == false) { return } // Do validation check
        // Calculate the temperature rise with the junction-ambient thermal resistance and check whether it is allowable
        let tempRiseJuncToAmb = thermalResistanceJuncToAmb * powerDissipated
        if (tempRiseJuncToAmb <= tempDelta) {
            noHeatsinkRequired = true
            print("Temperature rise: \(tempRiseJuncToAmb)")
        } else {
            noHeatsinkRequired = false
            // Therefore, calculate the heatsink requirement
            let totalThermalResistance: Double = tempDelta / powerDissipated
            heatsinkThermalResistance = totalThermalResistance - thermalResistanceJuncToCase
            print("Heatsink thermal resistance: \(heatsinkThermalResistance)")
            // If negative thermal resistance, heatsink is not capable
            if (heatsinkThermalResistance <= 0) {
                negativeHeatsinkThermalResistance = true
                heatsinkThermalResistance = 0
            }
        }
    }
    
    // Function to validate the user input for power and thermal resistance - return false if invalid
    func validatePowerThermalResistance() -> Bool {
        // Check if power dissipated is less than or equal to zero
        if (powerDissipated <= 0) {
            negativePowerDissipated = true
            return false
        }
        // Check if thermal resistances are less than or equal to zero
        if (thermalResistanceJuncToCase <= 0 || thermalResistanceJuncToAmb <= 0) {
            negativeThermalResistance = true
            return false
        }
        return true
    }
    
}
