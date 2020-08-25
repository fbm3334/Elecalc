//
//  SIPrefix.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import Foundation

// This enum is used to store SI prefixes
enum SIPrefix: Int, CaseIterable {
    case femto = -15
    case pico = -12
    case nano = -9
    case micro = -6
    case milli = -3
    case none = 0
    case kilo = 3
    case mega = 6
    case giga = 9
    case tera = 12
    case peta = 15
}
