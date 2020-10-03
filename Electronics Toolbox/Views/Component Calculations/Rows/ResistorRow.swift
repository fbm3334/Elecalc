//
//  ResistorRow.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import SwiftUI

struct ResistorRow: View {
    
    @State private var tempResistorValue: String = ""
    
    var resistorValue: ResistorValue
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        HStack {
            Text("\(resistorValue.value, specifier: "%.\(settings.decimalPlaces)f")\(resistorValue.prefix.description)")
        }
    }
}

struct ResistorRow_Previews: PreviewProvider {
    static var previews: some View {
        ResistorRow(resistorValue: ResistorValue(id: UUID(), value: 34.0, prefix: .kΩ))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
