//
//  CapacitorParallelSeries.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 08/10/2020.
//

import SwiftUI

struct CapacitorParallelSeries: View {
    @State var addViewIsPresented: Bool = false
    @State private var keyboardHeight: CGFloat = 0 // Keyboard height variable
    @EnvironmentObject var capacitorCalcs: CapacitorCalcs
    @EnvironmentObject var settings: Settings
    
    
    var body: some View {
        
        // Two different versions of the view - one for iOS 14 and one for iOS 13 - iOS 14 has its own capability for handling keyboard alignment, which conflicts with the AdaptiveKeyboard method.
        if #available(iOS 14.0, *) {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    Form {
                        Section(header: Text("Capacitor values")) {
                            CapacitorList()
                            Button(action: {
                                selectionHaptics() // Play the selection haptic
                                addViewIsPresented.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add a Capacitor")
                                }
                            }
                        }
                        Section(header: Text("Results")) {
                            ResultsSectionCapacitor()
                        }
                    }
                }
                
                VStack(alignment: .center) {
                    if addViewIsPresented {
                        HStack {
                            Spacer()
                            AddCapacitor(isPresented: $addViewIsPresented)
                            Spacer()
                        }
                    }
                }.animation(.spring())
                
            }.navigationBarTitle(Text("Parallel and Series Capacitors"))
            .navigationBarItems(trailing: EditButton())
        } else {
        
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    Form {
                        Section(header: Text("Capacitor values")) {
                            CapacitorList()
                            Button(action: {
                                selectionHaptics() // Play the selection haptic
                                addViewIsPresented.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add a Capacitor")
                                }
                            }
                        }
                        Section(header: Text("Results")) {
                            ResultsSectionCapacitor()
                        }
                    }
                }
                
                VStack(alignment: .center) {
                    if addViewIsPresented {
                        HStack {
                            Spacer()
                            AddCapacitor(isPresented: $addViewIsPresented)
                            Spacer()
                        }
                        
                    }
                }.animation(.spring())
                
            }.navigationBarTitle(Text("Parallel and Series Capacitors"))
            .navigationBarItems(trailing: EditButton())
            .keyboardAdaptive()
        }
    }
}

struct CapacitorParallelSeries_Previews: PreviewProvider {
    static var previews: some View {
        CapacitorParallelSeries()
    }
}

struct ResultsSectionCapacitor: View {
    @EnvironmentObject var capacitorCalcs: CapacitorCalcs
    @EnvironmentObject var settings: Settings
    var body: some View {
        // Show the results in a HStack
        HStack {
            Text("Parallel:")
                .bold()
            Spacer()
            Text("\(capacitorCalcs.parallelCalculated.value, specifier: "%.\(settings.decimalPlaces)f")\(capacitorCalcs.parallelCalculated.prefix.description)F")
                .multilineTextAlignment(.trailing)
        }
        HStack {
            Text("Series:")
            .bold()
            Spacer()
            Text("\(capacitorCalcs.seriesCalculated.value, specifier: "%.\(settings.decimalPlaces)f")\(capacitorCalcs.seriesCalculated.prefix.description)F")
                .multilineTextAlignment(.trailing)
        }
    }
}
