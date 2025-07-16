//
//  ContentView.swift
//  Edutainment The App
//
//  Created by MacRow on 16/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedNumber = 3
    @State private var questionsToBeAsked = 5
    @State private var showConfig = false
    @State private var numbersToQuiz = [4, 3, 5, 8, 9]
    @State private var questionPosition = 0
    
    var body: some View {
         NavigationStack {
             ZStack{
                 LinearGradient(
                    gradient: Gradient(colors: [(showConfig ? .orange.opacity(0.6) : .green.opacity(0.8) ), .white]),
                    startPoint: .top,
                    endPoint: .bottom
                 )
                 .ignoresSafeArea()
                 if showConfig { VStack {
                     Spacer()
                     Spacer()
                     Spacer()
                     Spacer()
                     VStack {
                         Text("Which and how many")
                             .fontWeight(.bold)
                             .padding()
                         Stepper("\(NumberFormatter.localizedString(from: NSNumber(value: selectedNumber), number: .spellOut).capitalized) Times Tables", value: $selectedNumber, in: 1...10)
                             .padding(.horizontal, 25)
                         Stepper("\(NumberFormatter.localizedString(from: NSNumber(value: questionsToBeAsked), number: .spellOut).capitalized) \(questionsToBeAsked == 1 ? "Question" : "Questions")", value: $questionsToBeAsked, in: 1...10)
                             .padding(.horizontal, 25)
                         Button("Tap to Play"){
                             createQuestions()
                             withAnimation(.easeInOut(duration: 0.3)){
                                 showConfig.toggle()
                             }
                         }
                         .padding()
                         .background()
                         .clipShape(.rect(cornerRadius: 10))
                     }
                     .frame(maxWidth: .infinity)
                     .padding(.vertical, 20)
                     .background(.ultraThinMaterial)
                     .clipShape(.rect(cornerRadius: 20))
                     .padding(20)
                     Spacer()
                 }
                 .navigationTitle("Math is Hard")
             }
                 else {
                     VStack {
                         Text("What is \(selectedNumber) x \(numbersToQuiz[questionPosition])?")
                             .font(.title)
                             .fontWeight(.bold)
                             .frame(maxWidth: .infinity)
                             .padding(20)
                             .background(.ultraThinMaterial)
                             .clipShape(.rect(cornerRadius: 20))
                             .padding(.top, 80)
                             .padding(.horizontal, 40)
                             .onAppear()
                         HStack {
                             Button("Toggle Back"){
                                 numbersToQuiz = []
                                 showConfig.toggle()
                             }
                             .padding()
                             Button("Toggle Back"){
                                 numbersToQuiz = []
                                 showConfig.toggle()
                             }
                             .padding()
                         }
                     }
            }
        }
        }
        
    }
    func createQuestions(){
        for _ in 1...questionsToBeAsked {
            numbersToQuiz.append(Int.random(in: 1..<40))
//            print("\(i) \(numbersToQuiz)")
        }
    }
}

#Preview {
    ContentView()
}
