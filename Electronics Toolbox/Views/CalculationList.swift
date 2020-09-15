//
//  CalculationList.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 24/08/2020.
//

import SwiftUI

struct CalculationList: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Component Calculations")) {
                    NavigationLink(String("Parallel and Series Resistors"), destination: ResistorCalculator())
                    NavigationLink(String("Parallel and Series Capacitors"), destination: CapacitorCalculator())
                    NavigationLink(String("Resistor Colour Code to Value"), destination: ResistorBandToValue())
                }
                
                Section(header: Text("Thermal Calculations")) {
                    NavigationLink(String("Heatsink Calculator"), destination: ThermalResistanceCalculator())
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Elecalc")
            
            WelcomeView()
        }
    }
}

struct CalculationList_Previews: PreviewProvider {
    static var previews: some View {
        CalculationList()
    }
}
