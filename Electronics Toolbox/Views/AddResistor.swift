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
                Text("Add a Resistor")
                    .bold()
                    .font(.largeTitle)
                // HStack with value entry
                HStack {
                    Text("Value")
                    Spacer()
                    TextField(String("Text"), value: $resistorCalcs.valueTemp, formatter: doubleFormatter)
                        .keyboardType(.numbersAndPunctuation)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Resistor prefix")
                    .multilineTextAlignment(.leading)
                    Spacer()
                }
                // Picker to select the prefix
                Picker(selection: $resistorCalcs.prefixTemp, label: Text("Prefix")) {
                    ForEach(SIResistorPrefixes.allCases, id: \.self) {
                        Text(String($0.description))
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                    
                // Button to confirm and add the resistor
                Button(action: {
                    print("Add")
                    // Add resistor
                    self.resistorCalcs.addTempElement()
                    self.resistorCalcs.calcParallelResistors(values: self.resistorCalcs.resistorValues)
                    self.resistorCalcs.calcSeriesResistors(values: self.resistorCalcs.resistorValues)
                    self.isPresented = false
                    
                }) {
                    Text("Add")
                }
            }
        
        }.padding()
            // Required to display properly on iPad
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct AddResistor_Previews: PreviewProvider {
//    static var previews: some View {
//        AddResistor(isPresented: <#T##Binding<Bool>#>)
//    }
//}
