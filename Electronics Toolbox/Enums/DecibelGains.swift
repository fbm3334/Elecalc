//
//  DecibelGains.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 17/09/2020.
//

import Foundation
import SwiftUI

// Enum to store the decibel gains (10 and 20)
enum DecibelGains: Int, CustomStringConvertible, CaseIterable {
    case power = 10
    case amplitude = 20
    
    var description: String {
        switch self {
        case .power: return "Power"
        case .amplitude: return "Amplitude"
        }
    }
}
