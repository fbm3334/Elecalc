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
                    TextField("Value", text: $capacitorCalcs.valueTempString)
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
                    ForEach(SIPrefixes.allCases, id: \.self) {
                        Text(String("\($0.description)F"))
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                    
                // Button to confirm and add the capacitor
                Button(action: {
                    print("Add")
                    
                    // Reload the view to commit the text change
                    // https://stackoverflow.com/questions/61268306/swiftui-enter-value-in-textfield-then-button-click-need-change-text-not-workin
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    // If the entered value is zero, then return nothing to stop the app from crashing
                    if (Double(self.capacitorCalcs.valueTempString)! <= 0) { return }
                    
                    if let val = Double(self.capacitorCalcs.valueTempString) {
                        self.capacitorCalcs.valueTemp = val
                        print(self.capacitorCalcs.valueTemp)
                        // If val = 0, then display an alert and return
                        
                    } else {
                        print("Value invalid")
                    }
                    
                    // Add capacitor
                    self.capacitorCalcs.addTempElement()
                    _ = self.capacitorCalcs.calcParallelCapacitors(values: self.capacitorCalcs.capacitorValues)
                    _ = self.capacitorCalcs.calcSeriesCapacitors(values: self.capacitorCalcs.capacitorValues)
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

