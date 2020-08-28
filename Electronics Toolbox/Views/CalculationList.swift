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
                    NavigationLink(String("Resistors"), destination: ResistorCalculator())
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Electronics Toolbox")
        }
    }
}

struct CalculationList_Previews: PreviewProvider {
    static var previews: some View {
        CalculationList()
    }
}
