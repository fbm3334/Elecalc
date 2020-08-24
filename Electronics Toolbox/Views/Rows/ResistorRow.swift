//
//  ResistorRow.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import SwiftUI

struct ResistorRow: View {
    
    @State private var resistorValues: String = ""
    
    var resistorValue: ComponentValue
    
    var body: some View {
        Text(String(resistorValue.value))
    }
}

struct ResistorRow_Previews: PreviewProvider {
    static var previews: some View {
        ResistorRow(resistorValue: ComponentValue(id: UUID(), value: 34.0, prefix: .kilo))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
