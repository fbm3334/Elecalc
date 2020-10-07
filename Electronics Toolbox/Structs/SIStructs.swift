//
//  SIStructs.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 26/09/2020.
//

import Foundation

// File containing all of the SI unit structs

// Struct used to store pairs of values and prefixes
struct SIValue: Identifiable, Hashable {
    var id = UUID() // Unique ID required to draw list
    var value: Double // Value
    var prefix: SIPrefixes // Prefix
}

