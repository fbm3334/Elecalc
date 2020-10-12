//
//  MDTextAck.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 12/10/2020.
//

import SwiftUI

struct MDTextAck: View {
    var body: some View {
        Form {
            // Section for linking to library on GitHub
            Section(header: Text("Library")) {
                Text("MDText v0.0.10 by Lambdo-Labs")
                // Link to load library
                if #available(iOS 14.0, *) {
                    Link(destination: URL(string: "https://github.com/Lambdo-Labs/MDText")!, label: {
                        Text("MDText on GitHub")
                    })
                } else {
                    // Links were only introduced in iOS 14, so the workaround is to use UIKit links.
                    Button("MDText on GitHub") {
                        UIApplication.shared.open(URL(string: "https://github.com/Lambdo-Labs/MDText")!)
                    }
                }
            }
            
            Section(header: Text("Licensing information")) {
                Text("This app uses the MDText library by Lambdo-Labs, which is licensed under the MIT License.")
                Text("Copyright (c) 2020 Lambdo-Labs\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.")
            }
        }.navigationBarTitle(Text("MDText"))
    }
}

struct MDTextAck_Previews: PreviewProvider {
    static var previews: some View {
        MDTextAck()
    }
}
