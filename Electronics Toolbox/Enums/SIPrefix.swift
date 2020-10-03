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

enum SIInductorPrefixes: Int, CustomStringConvertible, CaseIterable {
    case pH = -12
    case nH = -9
    case µH = -6
    case mH = -3
    case H = 0
    
    var description: String {
        switch self {
        case .pH: return "pH"
        case .nH: return "nH"
        case .µH: return "µH"
        case .mH: return "mH"
        case .H: return "H"
        }
    }
}

enum SITimePrefixes: Int, CustomStringConvertible, CaseIterable {
    case µs = -6
    case ms = -3
    case s = 0
    
    var description: String {
        switch self {
        case .µs: return "µs"
        case .ms: return "ms"
        case .s: return "s"
        }
    }
}

enum SIVoltagePrefixes: Int, CustomStringConvertible, CaseIterable {
    case nV = -9
    case µV = -6
    case mV = -3
    case V = 0
    case kV = 3
    
    var description: String {
        switch self {
        case .nV: return "nV"
        case .µV: return "µV"
        case .mV: return "mV"
        case .V: return "V"
        case .kV: return "kV"
        }
    }
}

enum SICurrentPrefixes: Int, CustomStringConvertible, CaseIterable {
    case nA = -9
    case µA = -6
    case mA = -3
    case A = 0
    case kA = 3
    
    var description: String {
        switch self {
        case .nA: return "nA"
        case .µA: return "µA"
        case .mA: return "mA"
        case .A: return "A"
        case .kA: return "kA"
        }
    }
}

enum SIFrequencyPrefixes: Int, CustomStringConvertible, CaseIterable {
    case Hz = 0
    case kHz = 3
    case MHz = 6
    case GHz = 9
    
    var description: String {
        switch self {
        case .Hz: return "Hz"
        case .kHz: return "kHz"
        case .MHz: return "MHz"
        case .GHz: return "GHz"
        }
    }
}

enum SIPowerPrefixes: Int, CustomStringConvertible, CaseIterable {
    case µW = -6
    case mW = -3
    case W = 0
    case kW = 3
    case MW = 6
    
    var description: String {
        switch self {
        case .µW: return "µW"
        case .mW: return "mW"
        case .W: return "W"
        case .kW: return "kW"
        case .MW: return "MW"
        }
    }
}
