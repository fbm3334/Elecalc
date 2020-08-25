//
//  ParallelResistorCalculator.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import SwiftUI

struct ParallelResistorCalculator: View {
    @EnvironmentObject var resistorCalcs: ResistorCalcs

    // State variable to show resistor add menu
    @State var showAddResistorView = false
    
    var body: some View {
        VStack {
            
        List {
            ForEach(resistorCalcs.resistorValues) { value in
                ResistorRow(resistorValue: value)
            }
                .onDelete(perform: delete)
        }
        
        .navigationBarItems(trailing: Button(action: {
            self.showAddResistorView.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
        }.sheet(isPresented: $showAddResistorView) {
            AddResistor(isPresented: self.$showAddResistorView).environmentObject(self.resistorCalcs)
            }
        )
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


