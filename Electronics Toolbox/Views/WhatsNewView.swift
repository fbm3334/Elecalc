//
//  WhatsNewView.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 27/09/2020.
//

import SwiftUI
import MDText

struct WhatsNewView: View {
    var body: some View {
        Form {
            Section() {
                HStack {
                    Text("What's new in version \(UIApplication.appVersion!)")
                        .font(.headline)
                        .bold()
                    Spacer()
                    Text("💡")
                        .font(.headline)
                }
                MDText(markdown: readWhatsNewMarkdown())
            }
        }
        .navigationBarTitle(Text("What's new"))
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewView()
    }
}

// Function to load WhatsNew.md
func readWhatsNewMarkdown() -> String {
    if let filePath = Bundle.main.path(forResource: "WhatsNew", ofType: "md") {
        do {
            let contents = try String(contentsOfFile: filePath)
            return contents
        } catch {
            return "Error - contents could not be loaded"
        }
        
    } else {
        return "File not found"
    }
}
