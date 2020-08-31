//
//  AddCapacitor.swift
//  Electronics Toolbox
//
//  Created by Finn Beckitt-Marshall on 31/08/2020.
//

import SwiftUI

struct AddCapacitor: View {
    
    @EnvironmentObject var capacitorCalcs: CapacitorCalcs
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
                Text("Add a Capacitor")
                    .bold()
                    .font(.largeTitle)
                // HStack with value entry
                HStack {
                    Text("Value")
                    Spacer()
                    TextField(String("Text"), value: $capacitorCalcs.valueTemp, formatter: doubleFormatter)
                        .keyboardType(.numbersAndPunctuation)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Capacitor prefix")
                    .multilineTextAlignment(.leading)
                    Spacer()
                }
                // Picker to select the prefix
                Picker(selection: $capacitorCalcs.prefixTemp, label: Text("Prefix")) {
                    ForEach(SICapacitorPrefixes.allCases, id: \.self) {
                        Text(String($0.description))
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                    
                // Button to confirm and add the capacitor
                Button(action: {
                    print("Add")
                    // Add capacitor
                    self.capacitorCalcs.addTempElement()
                    self.capacitorCalcs.calcParallelCapacitors(values: self.capacitorCalcs.capacitorValues)
                    self.capacitorCalcs.calcSeriesCapacitors(values: self.capacitorCalcs.capacitorValues)
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

//struct AddCapacitor_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCapacitor(isPresented: <#T##Binding<Bool>#>)
//    }
//}

