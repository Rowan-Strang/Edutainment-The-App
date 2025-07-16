//
//  ContentView.swift
//  Edutainment The App
//
//  Created by MacRow on 16/07/2025.
//

import SwiftUI

struct Answer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.black)
            .frame(maxWidth: 70)
            .padding(10)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 20))
            .padding()
    }
}

extension View {
    func answerStyle() -> some View {
        modifier(Answer())
    }
}


struct ContentView: View {
    @State private var selectedNumber = 1
    @State private var questionsToBeAsked = 5
    @State private var showConfig = true
    @State private var numbersToQuiz:[Int] = []
//    @State private var numbersToQuiz = [4, 3, 5, 8, 9]
    @State private var questionPosition = 0
    @State private var correctAnswer = 0
    @State private var multiChoice: [Int] = []
//    @State private var multiChoice = [12, 18, 7]
    @State private var answeredCorrectly = 0
    @State private var answeredIncorrectly = 0
    @State private var showingEndGame = false
    
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
                             prepareMultichoice()
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
                 else if !showingEndGame{
                     VStack {
                         Spacer()
                         Text("Wrong: \(answeredIncorrectly)")
                             .font(.largeTitle.bold())
                             .foregroundStyle(.black)
                         Text("Correct: \(answeredCorrectly)")
                             .font(.largeTitle.bold())
                             .foregroundStyle(.black)
                         Spacer()
                         Text("What is \(selectedNumber) x \(numbersToQuiz[questionPosition])?")
                             .font(.title)
                             .fontWeight(.bold)
                             .frame(maxWidth: .infinity)
                             .padding(20)
                             .background(.thinMaterial)
                             .clipShape(.rect(cornerRadius: 20))
                             .padding(.top, 80)
                             .padding(.horizontal, 40)
                         Spacer()
                         
                         HStack {
                             ForEach(multiChoice, id: \.self) { choice in
                                 Button("\(choice)"){
                                     validateAnswer(choice)
                                 }
                                 .answerStyle()
                             }
                         }
                         Spacer()
                     }
                 } else {
                     VStack{
                         Group{
                             if answeredCorrectly == questionsToBeAsked {
                                 Text("Perfect Score!")
                             } else {
                                 Text(answeredCorrectly > answeredIncorrectly ? "Well Done!" : "You Idiot")
                             }
                         }
                             .font(.largeTitle.bold())
                         Text("\(answeredCorrectly) / \(questionsToBeAsked)")
                             .padding()
                             .font(.title)
                         Button("Play Again"){
                             showConfig = true
                             showingEndGame = false
                             answeredCorrectly = 0
                             answeredIncorrectly = 0
                             questionsToBeAsked = 5
                             questionPosition = 0
                             
                         }
                         .padding()
                         .background()
                         .clipShape(.rect(cornerRadius: 10))
                     }
                         
                 }
        }
        }
        
    }
    func createQuestions(){
        numbersToQuiz = []
        for _ in 1...questionsToBeAsked {
            numbersToQuiz.append(Int.random(in: 1..<40))
//            print("\(i) \(numbersToQuiz)")
        }
    }
    
    func validateAnswer(_ number: Int){
        if number == correctAnswer {
            answeredCorrectly += 1
        } else {
            answeredIncorrectly += 1
        }

        if (questionPosition+1) < questionsToBeAsked {
            print("moving on")
            questionPosition += 1
            prepareMultichoice()
        } else {
            print("gameFinished")
            showingEndGame = true
        }
         
    }
    
    func prepareMultichoice(){
        correctAnswer = numbersToQuiz[questionPosition]*selectedNumber
        let dummyOne = correctAnswer - Int.random(in: 1..<10)
        let dummyTwo = correctAnswer + Int.random(in: 1..<10)
        multiChoice = [correctAnswer, dummyOne, dummyTwo].shuffled()
    }
    
    func resetGame(){
        
    }
}

#Preview {
    ContentView()
}
