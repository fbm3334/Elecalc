//
//  CapacitorCalculator.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 31/08/2020.
//

import SwiftUI

struct CapacitorCalculator: View {
    @EnvironmentObject var capacitorCalcs: CapacitorCalcs

    // State variable to show capacitor add menu
    @State var showAddCapacitorView = false
    
    var body: some View {

            
            List {
                Section(header: Text("Capacitors")) {
                    ForEach(capacitorCalcs.capacitorValues) { value in
                        CapacitorRow(capacitorValue: value)
                    }
                        .onDelete(perform: delete)
                    Button(action: {
                        self.showAddCapacitorView.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add a Capacitor")
                        }
                    }.sheet(isPresented: $showAddCapacitorView) {
                        AddCapacitor(isPresented: self.$showAddCapacitorView).environmentObject(self.capacitorCalcs)
                        }
                }
                Section(header: Text("Results")) {
                
                    // Show the results in a HStack
                    HStack {
                        Text("Parallel:")
                            .bold()
                        Spacer()
                        Text("\(capacitorCalcs.parallelCalculated.value, specifier: "%.2f")\(capacitorCalcs.parallelCalculated.prefix.description)")
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Series:")
                        .bold()
                        Spacer()
                        Text("\(capacitorCalcs.seriesCalculated.value, specifier: "%.2f")\(capacitorCalcs.seriesCalculated.prefix.description)")
                            .multilineTextAlignment(.trailing)
                    }
                }
                .navigationBarTitle(Text("Capacitors"))
                .listStyle(GroupedListStyle())
            }

            
        
        
    }
    
    // Delete function for removing value
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach {
            capacitorCalcs.capacitorValues.remove(at: $0)
            // Recalculate once the value has been removed
            self.capacitorCalcs.calcParallelCapacitors(values: self.capacitorCalcs.capacitorValues)
            self.capacitorCalcs.calcSeriesCapacitors(values: self.capacitorCalcs.capacitorValues)
        }
    }
}

struct CapacitorCalculator_Previews: PreviewProvider {
    static var previews: some View {
        CapacitorCalculator()
    }
}

