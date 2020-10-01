//
//  SIStructs.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 26/09/2020.
//

import Foundation

// File containing all of the SI unit structs

// Struct used to store pairs of values and prefixes
struct ResistorValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SIResistorPrefixes // Prefix
}

// Capacitor values struct
struct CapacitorValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SICapacitorPrefixes // Prefix
}

// Inductor values struct
struct InductorValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SIInductorPrefixes // Prefix
}

// Time values struct
struct TimeValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SITimePrefixes // Prefix
}

// Voltage values struct
struct VoltageValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SIVoltagePrefixes // Prefix
}

// Current values struct
struct CurrentValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SICurrentPrefixes // Prefix
}

// Frequency values struct
struct FrequencyValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SIFrequencyPrefixes // Prefix
}

// Power values struct
struct PowerValue: Identifiable, Hashable {
    var id = UUID()
    var value: Double
    var prefix: SIPowerPrefixes
}

