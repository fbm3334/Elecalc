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
                Section(header: Text("Unit Calculations")) {
                    NavigationLink(String("Ohm's Law Calculator"), destination: OhmsLaw())
                    NavigationLink(String("Power Calculator"), destination: PowerCalcs())
                }
                
                Section(header: Text("Component Calculations")) {
                    NavigationLink(String("Parallel and Series Resistors"), destination: ResistorParallelSeries())
                    NavigationLink(String("Parallel and Series Capacitors"), destination: CapacitorParallelSeries())
                    NavigationLink(String("Resistor Colour Code to Value"), destination: ResistorBandToValue())
                    NavigationLink(String("Potential Divider Calculator"), destination: PotentialDivider())
                    NavigationLink(String("LED Current-Limiting Resistor"), destination: LEDResistorCalculator())
                    NavigationLink(String("LC Resonance Calculator"), destination: LCResonanceCalculator())
                }
                
                Section(header: Text("Thermal Calculations")) {
                    NavigationLink(String("Heatsink Calculator"), destination: ThermalResistanceCalculator())
                }
                
                Section(header: Text("Gain Calculations")) {
                    NavigationLink(String("dB to Numeric Gain"), destination: DecibeltoNumericGain())
                    NavigationLink(String("Numeric to dB Gain"), destination: NumerictoDecibelGain())
                }
                
                Section(header: Text("Digital Calculations")) {
                    NavigationLink(String("Number Base Converter"), destination: NumberBaseCalc())
                }
                
                Section(header: Text("Settings")) {
                    NavigationLink(String("Settings"), destination: SettingsView())
                }
                
                Section(header: Text("Information")) {
                    NavigationLink(String("About this app"), destination: AboutView())
                    NavigationLink(String("What's new"), destination: WhatsNewView())
                }
            }
            .navigationBarTitle(Text("Elecalc"))
            .listStyle(GroupedListStyle())
            WelcomeView()
                
        }
    }
}

struct CalculationList_Previews: PreviewProvider {
    static var previews: some View {
        CalculationList()
    }
}
