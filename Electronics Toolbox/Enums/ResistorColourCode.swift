//
//  ResistorColourCode.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 31/08/2020.
//

import Foundation

// Enum for colour code
enum ResistorColourCode: Int, CustomStringConvertible, CaseIterable {
    case black = 0
    case brown = 1
    case red = 2
    case orange = 3
    case yellow = 4
    case green = 5
    case blue = 6
    case violet = 7
    case grey = 8
    case white = 9
    
    var description: String {
        switch self {
        case .black: return "Black (0)"
        case .brown: return "Brown (1)"
        case .red: return "Red (2)"
        case .orange: return "Orange (3)"
        case .yellow: return "Yellow (4)"
        case .green: return "Green (5)"
        case .blue: return "Blue (6)"
        case .violet: return "Violet (7)"
        case .grey: return "Grey (8)"
        case .white: return "White (9)"
        }
    }
}

// Enum for multiplier
enum ResistorMultiplier: Int, CustomStringConvertible, CaseIterable {
    case silver = -2
    case gold = -1
    case black = 0
    case brown = 1
    case red = 2
    case orange = 3
    case yellow = 4
    case green = 5
    case blue = 6
    case violet = 7
    case grey = 8
    case white = 9
    
    var description: String {
        switch self {
        case .silver: return "Silver (10⁻²)"
        case .gold: return "Gold (10⁻¹)"
        case .black: return "Black (10⁰)"
        case .brown: return "Brown (10¹)"
        case .red: return "Red (10²)"
        case .orange: return "Orange (10³)"
        case .yellow: return "Yellow (10⁴)"
        case .green: return "Green (10⁵)"
        case .blue: return "Blue (10⁶)"
        case .violet: return "Violet (10⁷)"
        case .grey: return "Grey (10⁸)"
        case .white: return "White (10⁹)"
        }
    }
}

enum ResistorTolerance: Int, CustomStringConvertible, CaseIterable {
    case none = 0
    case silver = 1
    case gold = 2
    case brown = 3
    case red = 4
    case green = 5
    case blue = 6
    case violet = 7
    case grey = 8
    
    var description: String {
        switch self {
        case .none: return "None (±20%)"
        case .silver: return "Silver (±10%)"
        case .gold: return "Gold (±5%)"
        case .brown: return "Brown (±1%)"
        case .red: return "Red (±2%)"
        case .green: return "Green (±0.5%)"
        case .blue: return "Blue (±0.25%)"
        case .violet: return "Violet (±0.1%)"
        case .grey: return "Grey (±0.05%)"
        }
    }
}

enum NumberOfResistorBands: Int, CustomStringConvertible, CaseIterable {
    case four = 4
    case five = 5
    
    var description: String {
        switch self {
        case .four: return "4"
        case .five: return "5/6"
        }
    }
}
