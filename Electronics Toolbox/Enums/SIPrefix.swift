//
//  SIPrefix.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import Foundation
import SwiftUI

// This enum is used to store SI prefixes for resistors
enum SIResistorPrefixes: Int, CustomStringConvertible, CaseIterable {
    case µΩ = -6
    case mΩ = -3
    case Ω = 0
    case kΩ = 3
    case MΩ = 6
    case GΩ = 9
    
    var description: String {
        switch self {
        case .µΩ: return "µΩ"
        case .mΩ: return "mΩ"
        case .Ω: return "Ω"
        case .kΩ: return "kΩ"
        case .MΩ: return "MΩ"
        case .GΩ: return "GΩ"
        }
    }
}

enum SICapacitorPrefixes: Int, CustomStringConvertible, CaseIterable {
    case pF = -12
    case nF = -9
    case µF = -6
    case mF = -3
    case F = 0
    
    var description: String {
        switch self {
        case .pF: return "pF"
        case .nF: return "nF"
        case .µF: return "µF"
        case .mF: return "mF"
        case .F: return "F"
        }
    }
}
