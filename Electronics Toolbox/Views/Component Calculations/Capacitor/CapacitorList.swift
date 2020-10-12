//
//  CapacitorList.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 08/10/2020.
//

import SwiftUI

struct CapacitorList: View {
    @EnvironmentObject var capacitorCalcs: CapacitorCalcs
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        ForEach(capacitorCalcs.capacitorValues) { value in
            CapacitorRow(capacitorValue: value)
        }
            .onDelete(perform: delete)
        
        }
    
    // Delete function for removing value
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach {
            capacitorCalcs.capacitorValues.remove(at: $0)
            // Recalculate once the value has been removed
            _ = self.capacitorCalcs.calcParallelCapacitors(values: self.capacitorCalcs.capacitorValues)
            _ = self.capacitorCalcs.calcSeriesCapacitors(values: self.capacitorCalcs.capacitorValues)
        }
    }
}

struct CapacitorList_Previews: PreviewProvider {
    static var previews: some View {
        CapacitorList()
    }
}
