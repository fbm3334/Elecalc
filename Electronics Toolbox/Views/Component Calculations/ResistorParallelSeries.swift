//
//  ResistorParallelSeries.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 07/10/2020.
//

import SwiftUI

struct ResistorParallelSeries: View {
    
    @State var addViewIsPresented: Bool = false
    
    
    var body: some View {
        
        ZStack {
            VStack {
                Form {
                    Section(header: Text("Resistor values")) {
                        ResistorList()
                        Button(action: {
                            selectionHaptics() // Play the selection haptic
                            addViewIsPresented.toggle()
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add a Resistor")
                            }
                        }
                    }
                }
            }
            
            VStack {
                if addViewIsPresented {
                    AddResistor(isPresented: $addViewIsPresented)
                        
                }
            }.animation(.spring())
            
            
        }.navigationBarTitle(Text("Parallel and Series Resistors"))
    }
}

struct ResistorParallelSeries_Previews: PreviewProvider {
    static var previews: some View {
        ResistorParallelSeries()
    }
}
