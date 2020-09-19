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
                    NavigationLink(String("LED Current-Limiting Resistor"), destination: LEDResistorCalculator())
                }
                
                Section(header: Text("Thermal Calculations")) {
                    NavigationLink(String("Heatsink Calculator"), destination: ThermalResistanceCalculator())
                }
                
                Section(header: Text("Gains")) {
                    NavigationLink(String("dB to Numeric Gain"), destination: DecibeltoNumericGain())
                    NavigationLink(String("Numeric to dB Gain"), destination: NumerictoDecibelGain())
                }
                
                Section(header: Text("Information")) {
                    NavigationLink(String("About this app"), destination: AboutView())
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
