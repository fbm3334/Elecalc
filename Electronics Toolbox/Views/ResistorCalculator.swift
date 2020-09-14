//
//  ResistorCalculator.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import SwiftUI

struct ResistorCalculator: View {
    @EnvironmentObject var resistorCalcs: ResistorCalcs

    // State variable to show resistor add menu
    @State var showAddResistorView = false
    
    var body: some View {

            
            List {
                Section(header: Text("Resistors")) {
                    ForEach(resistorCalcs.resistorValues) { value in
                        ResistorRow(resistorValue: value)
                    }
                        .onDelete(perform: delete)
                    Button(action: {
                        self.showAddResistorView.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add a Resistor")
                        }
                    }.sheet(isPresented: $showAddResistorView) {
                        AddResistor(isPresented: self.$showAddResistorView).environmentObject(self.resistorCalcs)
                        }
                }
                Section(header: Text("Results")) {
                
                    // Show the results in a HStack
                    HStack {
                        Text("Parallel:")
                            .bold()
                        Spacer()
                        Text("\(resistorCalcs.parallelCalculated.value, specifier: "%.2f")\(resistorCalcs.parallelCalculated.prefix.description)")
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Series:")
                        .bold()
                        Spacer()
                        Text("\(resistorCalcs.seriesCalculated.value, specifier: "%.2f")\(resistorCalcs.seriesCalculated.prefix.description)")
                            .multilineTextAlignment(.trailing)
                    }
                }
                .navigationBarTitle(Text("Resistors"))
                .listStyle(GroupedListStyle())
            }

            
        
        
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

struct ResistorCalculator_Previews: PreviewProvider {
    static var previews: some View {
        ResistorCalculator()
    }
}


