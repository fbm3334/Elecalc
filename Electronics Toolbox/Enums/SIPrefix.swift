//
//  SIPrefix.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import Foundation
import SwiftUI

// This enum is used to store SI prefixes for resistors
enum SIPrefixes: Int, CustomStringConvertible, CaseIterable {
    case p = -12
    case n = -9
    case µ = -6
    case m = -3
    case none = 0
    case k = 3
    case M = 6
    case G = 9
    
    var description: String {
        switch self {
        
        case .p:
            return "p"
        case .n:
            return "n"
        case .µ:
            return "µ"
        case .m:
            return "m"
        case .none:
            return ""
        case .k:
            return "k"
        case .M:
            return "M"
        case .G:
            return "G"
        }
    }
}
