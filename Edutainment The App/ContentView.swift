//
//  ContentView.swift
//  Edutainment The App
//
//  Created by MacRow on 16/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedNumber = 1
    
    var body: some View {
        VStack {
            Section(""){
                Stepper("\(NumberFormatter.localizedString(from: NSNumber(value: selectedNumber), number: .spellOut).capitalized) Times Tables", value: $selectedNumber, in: 1...10)

                .padding(20)
            }
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world! \(selectedNumber)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
