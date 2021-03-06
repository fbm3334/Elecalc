//
//  ResistorParallelSeries.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 07/10/2020.
//

import SwiftUI

struct ResistorParallelSeries: View {
    
    @State var addViewIsPresented: Bool = false
    @State private var keyboardHeight: CGFloat = 0 // Keyboard height variable
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    @EnvironmentObject var settings: Settings
    
    
    var body: some View {
        
        // Two different versions of the view - one for iOS 14 and one for iOS 13 - iOS 14 has its own capability for handling keyboard alignment, which conflicts with the AdaptiveKeyboard method.
        if #available(iOS 14.0, *) {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    Form {
                        Section(header: Text("Resistor values")) {
                            ResistorList()
                            Button(action: {
                                selectionHaptics() // Play the selection haptic
                                addViewIsPresented.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add a Resistor")
                                }
                            }
                        }
                        Section(header: Text("Results")) {
                            ResultsSectionResistor()
                        }
                        
                        // Section for explanation
                        Section(header: Text("Explanation")) {
                            ResistorExplanationView()
                        }
                    }
                }
                
                VStack(alignment: .center) {
                    if addViewIsPresented {
                        HStack {
                            Spacer()
                            AddResistor(isPresented: $addViewIsPresented)
                            Spacer()
                        }
                    }
                }.animation(.spring())
                
            }.navigationBarTitle(Text("Parallel and Series Resistors"))
            .navigationBarItems(trailing: EditButton())
        } else {
        
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    Form {
                        Section(header: Text("Resistor values")) {
                            ResistorList()
                            Button(action: {
                                selectionHaptics() // Play the selection haptic
                                addViewIsPresented.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add a Resistor")
                                }
                            }
                        }
                        Section(header: Text("Results")) {
                            ResultsSectionResistor()
                        }
                        
                        // Section for explanation
                        Section(header: Text("Explanation")) {
                            ResistorExplanationView()
                        }
                    }
                }
                
                VStack(alignment: .center) {
                    if addViewIsPresented {
                        HStack {
                            Spacer()
                            AddResistor(isPresented: $addViewIsPresented)
                            Spacer()
                        }
                        
                    }
                }.animation(.spring())
                
            }.navigationBarTitle(Text("Parallel and Series Resistors"))
            .navigationBarItems(trailing: EditButton())
            .keyboardAdaptive()
        }
    }
}

struct ResistorParallelSeries_Previews: PreviewProvider {
    static var previews: some View {
        ResistorParallelSeries()
    }
}


struct ResultsSectionResistor: View {
    @EnvironmentObject var resistorCalcs: ResistorCalcs
    @EnvironmentObject var settings: Settings
    // Pasteboard for clipboard
    let pasteboard = UIPasteboard.general
    
    var body: some View {
        // Show the results in a HStack
        HStack {
            Text("Parallel:")
                .bold()
            Spacer()
            Text("\(resistorCalcs.parallelCalculated.value, specifier: "%.\(settings.decimalPlaces)f")\(resistorCalcs.parallelCalculated.prefix.description)Ω")
                .multilineTextAlignment(.trailing)
            Button(action: {
                pasteboard.string = "\(resistorCalcs.parallelCalculated.value)\(resistorCalcs.parallelCalculated.prefix.description)Ω"
            }) {
                Image(systemName: "doc.on.doc")
            }.buttonStyle(BorderlessButtonStyle())
        }
        HStack {
            Text("Series:")
            .bold()
            Spacer()
            Text("\(resistorCalcs.seriesCalculated.value, specifier: "%.\(settings.decimalPlaces)f")\(resistorCalcs.seriesCalculated.prefix.description)Ω")
                .multilineTextAlignment(.trailing)
            Button(action: {
                pasteboard.string = "\(resistorCalcs.seriesCalculated.value)\(resistorCalcs.seriesCalculated.prefix.description)Ω"
            }) {
                Image(systemName: "doc.on.doc")
            }.buttonStyle(BorderlessButtonStyle())
        }
    }
}

// Seperate struct for resistor explanations so do not have to repeat
struct ResistorExplanationView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("This calculator calculates resistors in series and parallel, using the following equations:")
            // Using HStack and spacers to centre
            HStack {
                Spacer()
                // Image must be resizeable - the equations do not fit on 4" iOS devices.
                Image("ResistorEqns")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    // Frame for 326x92 optimum size (resolution of 1x image)
                    .frame(minWidth: 0, idealWidth: 326, maxWidth: 326, minHeight: 0, idealHeight: 92, maxHeight: 92, alignment: .center)
                Spacer()
            }
        }
    }
}
