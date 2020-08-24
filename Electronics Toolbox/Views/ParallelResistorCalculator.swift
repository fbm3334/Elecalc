//
//  ParallelResistorCalculator.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import SwiftUI

struct ParallelResistorCalculator: View {
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    @State private var editMode = EditMode.inactive
    var body: some View {
        VStack {
            
        List {
            ForEach(resistorCalcs.resistorValues) { value in
                Text(String(value.value))
            }
                .onDelete(perform: delete)
        }
        
            .navigationBarItems(trailing: Button(action: {
                self.resistorCalcs.addToArray()
                print("Add pressed")
            }) {
                Image(systemName: "plus.circle.fill")
            })
            .navigationBarTitle(Text("Parallel Resistors"))
        }
        
    }
    
    // Delete function for
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach {
            resistorCalcs.resistorValues.remove(at: $0)
        }
    }
}

struct ParallelResistorCalculator_Previews: PreviewProvider {
    static var previews: some View {
        ParallelResistorCalculator()
    }
}


