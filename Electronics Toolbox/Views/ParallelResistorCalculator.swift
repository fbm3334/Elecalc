//
//  ParallelResistorCalculator.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import SwiftUI

struct ParallelResistorCalculator: View {
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    var body: some View {
        
        List {
            Text("Parallel Calc")
        }
        HStack {
            Button(action: {
                print("Add pressed")
            }) {
                Image(systemName: "plus.circle.fill")
            }
            Spacer()
            // Remove button (removes resistor)
            Button(action: {
                print("Remove pressed")
            }) {
                Image(systemName: "minus.circle.fill")
            }
            Button(action: {
                resistorCalcs.resetArray()
                print("Clear pressed")
            }) {
                Text("Clear")
            }
        }
            
            .navigationBarTitle(Text("Parallel Resistors"))
    }
}

struct ParallelResistorCalculator_Previews: PreviewProvider {
    static var previews: some View {
        ParallelResistorCalculator()
    }
}
