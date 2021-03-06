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
    @Environment(\.colorScheme) var colourScheme // Colour scheme variable
    
    @State var valueInvalid: Bool = false
    
    var body: some View {
        ZStack {
            if (colourScheme == .dark) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray)
                }
                    .frame(minWidth: 280, idealWidth: 400, maxWidth: 400, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: .center)
                    
                    
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(minWidth: 280, idealWidth: 400, maxWidth: 400, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: .center)
                    
                    .shadow(radius: 10)
            }
            
            // Title
            VStack {
                Text("Add a Capacitor")
                    .bold()
                    .font(.title)
                // HStack with value entry
                HStack {
                    Text("Value")
                    Spacer()
                    TextField("Value", text: $capacitorCalcs.valueTempString)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.trailing)
                    // Picker to select the prefix
                    
                }
                
                Picker(selection: $capacitorCalcs.prefixTemp, label: Text("Prefix")) {
                    ForEach(SIPrefixes.allCases, id: \.self) {
                        Text(String("\($0.description)F"))
                    }
                }
                    .pickerStyle(SegmentedPickerStyle())
                // Place the buttons in a HStack to have them both next to each other
                HStack {
                // Button to confirm and add the capacitor
                    Button(action: {
                        print("Add")
                        
                        // Reload the view to commit the text change
                        // https://stackoverflow.com/questions/61268306/swiftui-enter-value-in-textfield-then-button-click-need-change-text-not-workin
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                        // If the entered value is zero, then return nothing to stop the app from crashing
                        if (Double(self.capacitorCalcs.valueTempString)! <= 0) {
                            valueInvalid = true
                            // Play the error haptic
                            errorHaptics()
                            return
                        } else {
                            successHaptics()
                        }
                        
                        if let val = Double(self.capacitorCalcs.valueTempString) {
                            self.capacitorCalcs.valueTemp = val
                            print(self.capacitorCalcs.valueTemp)
                            
                            
                        } else {
                            print("Value invalid")
                            
                        }
                        
                        // Add capacitor
                        self.capacitorCalcs.addTempElement()
                        _ = self.capacitorCalcs.calcParallelCapacitors(values: self.capacitorCalcs.capacitorValues)
                        _ = self.capacitorCalcs.calcSeriesCapacitors(values: self.capacitorCalcs.capacitorValues)
                        //self.isPresented = false
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                        Text("Add")
                    }.alert(isPresented: $valueInvalid) {
                        Alert(title: Text("The capacitance value is less than or equal to zero."), message: Text("Please check your value."), dismissButton: .default(Text("OK")))
                    }
                    Spacer(minLength: 10)
                    // Button to cancel adding the capacitor
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                        Text("Close")
                    }
                }
            }
            .frame(minWidth: 260, idealWidth: 380, maxWidth: 380, minHeight: 180, idealHeight: 180, maxHeight: 180, alignment: .center)
            .padding()
        }.padding()
        
            
    }
}
//struct AddCapacitor_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCapacitor(isPresented: <#T##Binding<Bool>#>)
//    }
//}

