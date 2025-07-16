//
//  ContentView.swift
//  Edutainment The App
//
//  Created by MacRow on 16/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedNumber = 1
    @State private var questionsToBeAsked = 1
    
    var body: some View {
        NavigationStack {
            Form {
                Section("which and how many"){
                    Stepper("\(NumberFormatter.localizedString(from: NSNumber(value: selectedNumber), number: .spellOut).capitalized) Times Tables", value: $selectedNumber, in: 1...10)
                    Stepper("\(NumberFormatter.localizedString(from: NSNumber(value: questionsToBeAsked), number: .spellOut).capitalized) \(questionsToBeAsked == 1 ? "Question" : "Questions")", value: $questionsToBeAsked, in: 1...10)
                }
            }
            .navigationTitle("Math is Hard")
        }
    }
}

#Preview {
    ContentView()
}
