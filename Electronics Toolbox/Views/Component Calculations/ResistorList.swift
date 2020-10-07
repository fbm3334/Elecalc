//
//  ResistorList.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 07/10/2020.
//

import SwiftUI

struct ResistorList: View {
    
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        ForEach(resistorCalcs.resistorValues) { value in
            ResistorRow(resistorValue: value)
        }
            .onDelete(perform: delete)
        
        }
    
    // Delete function for removing value
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach {
            resistorCalcs.resistorValues.remove(at: $0)
            // Recalculate once the value has been removed
            _ = self.resistorCalcs.calcParallelResistors(values: self.resistorCalcs.resistorValues)
            _ = self.resistorCalcs.calcSeriesResistors(values: self.resistorCalcs.resistorValues)
        }
    }
    }
    
    


struct ResistorList_Previews: PreviewProvider {
    static var previews: some View {
        ResistorList()
    }
}
