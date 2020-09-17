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
                    TextField("Value", text: $resistorCalcs.valueTempString)
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
                    
                    // Reload the view to commit the text change
                    // https://stackoverflow.com/questions/61268306/swiftui-enter-value-in-textfield-then-button-click-need-change-text-not-workin
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    // If the entered value is zero, then return nothing to stop the app from crashing
                    if (Double(self.resistorCalcs.valueTempString)! <= 0) { return }
                    
                    if let val = Double(self.resistorCalcs.valueTempString) {
                        self.resistorCalcs.valueTemp = val
                        print(self.resistorCalcs.valueTemp)
                        // If val = 0, then display an alert and return
                        
                    } else {
                        print("Value invalid")
                    }
                    
                    // Add resistor
                    self.resistorCalcs.addTempElement()
                    _ = self.resistorCalcs.calcParallelResistors(values: self.resistorCalcs.resistorValues)
                    _ = self.resistorCalcs.calcSeriesResistors(values: self.resistorCalcs.resistorValues)
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
