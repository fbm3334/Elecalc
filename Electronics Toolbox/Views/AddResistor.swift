//
//  AddResistor.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 25/08/2020.
//

import SwiftUI

struct AddResistor: View {
    
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    @Binding var isPresented: Bool
    
    // Configure the number formatter
    var doubleFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 5
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            // Title
            VStack {
                // HStack with value entry
                HStack {
                    Text("Value")
                    Spacer()
                    TextField(String("Text"), value: $resistorCalcs.valueTemp, formatter: doubleFormatter)
                        .keyboardType(.numbersAndPunctuation)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.trailing)
                }
                Text("Resistor prefix")
                    .multilineTextAlignment(.leading)
                // Picker to select the prefix
                Picker(selection: $resistorCalcs.prefixTemp, label: Text("Prefix")) {
                    ForEach(SIPrefix.allCases, id: \.self) {
                        Text(String($0.rawValue))
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                    
                // Button to confirm and add the resistor
                Button(action: {
                    print("Add")
                    // Add resistor
                    self.resistorCalcs.addTempElement()
                    self.resistorCalcs.calcParallelResistors(values: self.resistorCalcs.resistorValues)
                    self.isPresented = false
                    
                }) {
                    Text("Add")
                }
            .navigationBarTitle("Add a resistor")
            }
            
        }.padding()

    }
}

//struct AddResistor_Previews: PreviewProvider {
//    static var previews: some View {
//        AddResistor(isPresented: <#T##Binding<Bool>#>)
//    }
//}
