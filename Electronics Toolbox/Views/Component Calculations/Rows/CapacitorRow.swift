//
//  CapacitorRow.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 31/08/2020.
//

import SwiftUI

struct CapacitorRow: View {
    
    @State private var tempCapacitorValue: String = ""
    
    var capacitorValue: CapacitorValue
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        HStack {
            Text("\(capacitorValue.value, specifier: "%.\(settings.decimalPlaces)f")\(capacitorValue.prefix.description)")
        }
    }
}

struct CapacitorRow_Previews: PreviewProvider {
    static var previews: some View {
        CapacitorRow(capacitorValue: CapacitorValue(id: UUID(), value: 34.0, prefix: .µF))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}

