//
//  Juego3View.swift
//  Bluet
//
//  Created by Alumno on 15/10/24.
//
//import SwiftUI
//
//
//struct Juego3View: View {
//    var body: some View {
//        VStack {
//            Text("Bienvenido a Juego 3")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//            // Add more content for Juego 3 here
//        }
//    }
//}
//
//struct Juego3_Previews: PreviewProvider {
//    static var previews: some View {
//        Juego3View()
//    }
//}

import SwiftUI

//struct Sign: Identifiable {
//    let id = UUID()
//    let name: String
//    let imageName: String
//}

struct Juego3View: View {
    @State private var signs: [Sign] = [
        Sign(name: "A", imageName: "signA"),
        Sign(name: "B", imageName: "signB"),
        Sign(name: "C", imageName: "signC"),
        Sign(name: "D", imageName: "signD"),
        Sign(name: "E", imageName: "signE"),
        Sign(name: "F", imageName: "signF"),
        Sign(name: "G", imageName: "signG"),
        Sign(name: "H", imageName: "signH"),
        Sign(name: "I", imageName: "signI"),
        Sign(name: "J", imageName: "signJ"),
        Sign(name: "K", imageName: "signK"),
        Sign(name: "L", imageName: "signL"),
        Sign(name: "LL", imageName: "signLL"),
        Sign(name: "M", imageName: "signM"),
        Sign(name: "N", imageName: "signN"),
        Sign(name: "Ñ", imageName: "signÑ"),
        Sign(name: "O", imageName: "signO"),
        Sign(name: "P", imageName: "signP"),
        Sign(name: "Q", imageName: "signQ"),
        Sign(name: "R", imageName: "signR"),
        Sign(name: "RR", imageName: "signRR"),
        Sign(name: "S", imageName: "signS"),
        Sign(name: "T", imageName: "signT"),
        Sign(name: "U", imageName: "signU"),
        Sign(name: "V", imageName: "signV"),
        Sign(name: "W", imageName: "signW"),
        Sign(name: "X", imageName: "signX"),
        Sign(name: "Y", imageName: "signY"),
        Sign(name: "Z", imageName: "signZ")
    ]
    
    @State private var currentSign: Sign? = nil
    @State private var answerOptions: [String] = []
    @State private var correctAnswer: String? = nil
    @State private var selectedAnswer: String? = nil
    @State private var isAnswerCorrect: Bool? = nil
    @State private var score: Int = 0
    
    @State private var showCorrectTick = false
    @State private var showIncorrectX = false
    
    // funcion para empezar juego
    func startGame() {
        currentSign = signs.randomElement()
        

        if let currentSign = currentSign {
            correctAnswer = currentSign.name
            var options = [correctAnswer!]
            let otherSigns = signs.filter { $0.name != correctAnswer }.shuffled().prefix(2)
            options.append(contentsOf: otherSigns.map { $0.name })
            answerOptions = options.shuffled()
        }
        selectedAnswer = nil
        isAnswerCorrect = nil
    }

    // misma funcion que checka por opcion correcta
    func checkAnswer(_ answer: String) {
        if answer == correctAnswer {
            score += 1
            showCorrectTick = true
            isAnswerCorrect = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showCorrectTick = false
            }
        } else {
            showIncorrectX = true
            isAnswerCorrect = false

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showIncorrectX = false
            }
        }
        // Restart the game after a brief delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            startGame()
        }
    }
    
    // funcion para asignar color de fondo de la opcion
    func backgroundColor(for answer: String) -> Color {
        if let isAnswerCorrect = isAnswerCorrect, let selectedAnswer = selectedAnswer {
            if answer == selectedAnswer {
                return isAnswerCorrect ? .green : .red
            }
        }
        return .white
    }

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Puntos: \(score)")
                    .font(.headline)
                    .padding()
                
                // Display the current sign image
                if let currentSign = currentSign {
                    Image(currentSign.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding()
                }
                
                Text("¿Cuál es el nombre de esta seña?")
                    .font(.title2)
                    .padding()
                
                //  stack de las opciones
                VStack(spacing: 20) {
                    ForEach(answerOptions, id: \.self) { option in
                        Button(action: {
                            checkAnswer(option)
                        }) {
                            Text(option)
                                .font(.title2)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(backgroundColor(for: option))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            
            if showCorrectTick {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 100, height: 100)
                    .transition(.scale)
                    .zIndex(1)
            }
            
            if showIncorrectX {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 100, height: 100)
                    .transition(.scale)
                    .zIndex(1)
            }
        }
        .onAppear {
            startGame()
        }
    }
}

struct Juego3_Previews: PreviewProvider {
    static var previews: some View {
        Juego3View()
    }
}

