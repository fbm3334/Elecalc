//
//  AboutView.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 16/09/2020.
//

import SwiftUI

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}

struct AboutView: View {
    
    
    
    var body: some View {
        Form {
            Section(header: Text("About")) {
                HStack {
                    // Spacers used to centre (multilineTextAlignment is not working for some reason)
                    Spacer()
                    VStack {
                        Image("1024px rounded noBG")
                            .resizable()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .multilineTextAlignment(.center)
                        Text("Elecalc")
                            .font(.title)
                            .fontWeight(.bold)
                        Text(UIApplication.appVersion!)
                        Text("Build \(UIApplication.appBuild!)")
                        Text("© 2020 Finn Beckitt-Marshall")
                            .font(.caption)
                    }
                    Spacer()
                }
            }
            Section(header: Text("Repository")) {
                if #available(iOS 14.0, *) {
                    Link(destination: URL(string: "https://github.com/fbm3334/Elecalc")!, label: {
                        Text("GitHub")
                    })
                } else {
                    // Links were only introduced in iOS 14, so the workaround is to use a copyable TextField.
                    VStack {
                        TextField("Placeholder", text: .constant("https://github.com/fbm3334/Elecalc"))
                        Text("Copy and paste this link into a web browser to view the GitHub repository.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .multilineTextAlignment(.leading)
                    
                }
            }
            
            // Licensing section
            Section(header: Text("Licensing")) {
                Text("This app is licensed under the MIT License.")
                Text("Copyright (c) 2020 Finn Beckitt-Marshall\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.")
            }
            
        }
    .navigationBarTitle(String("About this app"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
