//
//  Juego2View.swift
//  Bluet
//
//  Created by Alumno on 15/10/24.
//
import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let isSignName: Bool
    let sign: Sign
    var isFlipped: Bool = false
    var isMatched: Bool = false
}

//inicio view
struct Juego2View: View {
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
    
    @State private var cards: [Card] = []
    @State private var flippedCards: [Card] = []
    @State private var score: Int = 0

    // funcion inicio de juego
    func setupGame() {
        //6 señas al azar
        let shuffledSigns = signs.shuffled().prefix(6)
        var newCards: [Card] = []
        print("testing")
        // crea una carta text y carta imagen por cada signo
        for sign in shuffledSigns {
            newCards.append(Card(isSignName: true, sign: sign))  // carta nombre
            newCards.append(Card(isSignName: false, sign: sign)) // carta imagen
        }
        
        // declara las cartas a ser el valor de "nuevascartas" al azar (usando el metodo shuffled())
        cards = newCards.shuffled()
    }

    // funcion para voltear carta
    func flipCard(_ card: Card) {
        //ignora el caso donde la carta ya este "matcheada" o si dos ya han sido volteadas
        //guard es un tipo de try catch
        guard !card.isMatched, flippedCards.count < 2 else { return }

        // voltear la carta
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isFlipped = true
            flippedCards.append(cards[index])
        }

        // cuando la lista de cartas voteadas es 2, corre funcion checkMatch()
        if flippedCards.count == 2 {
            checkMatch()
        }
    }

    // funcion que checa si las dos cartas corresponden
    func checkMatch() {
        //crea una cola .now(), es para ahora, +1 es para agregar un segundo
        //inicio de cola
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if flippedCards.count == 2 {
                let firstCard = flippedCards[0]
                let secondCard = flippedCards[1]
                
                // par es cuando el id de las dos es el mismo y uno es el nombre y el otro el signo
                if firstCard.sign.id == secondCard.sign.id && firstCard.isSignName != secondCard.isSignName {
                    //marcar las cartas como un par
                    //la primera carta
                    if let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }) {
                        cards[firstIndex].isMatched = true
                    }
                    //la segunda carta
                    if let secondIndex = cards.firstIndex(where: { $0.id == secondCard.id }) {
                        cards[secondIndex].isMatched = true
                    }
                    score += 1 // variable de entorno
                } else {
                    // cuando no hay match
                    //la primera carta
                    if let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }) {
                        cards[firstIndex].isFlipped = false
                    }
                    //la segunda carta
                    if let secondIndex = cards.firstIndex(where: { $0.id == secondCard.id }) {
                        cards[secondIndex].isFlipped = false
                    }
                }
                // borra la lista de cartas volteadas
                flippedCards.removeAll()
            }
        }
        //fin de cola
    }
    //fin de checkMatch()
//inicio de body
    var body: some View {
        //inicio de z stack
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Memorama")
                    .font(.largeTitle)
                    .padding()
                
                Text("Puntos: \(score)")
                    .font(.headline)
                    .padding()
                
                // grid de cartas
                //son 3 columnas
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    //por cada carta
                    ForEach(cards) { card in
                        ZStack {
                            if card.isFlipped || card.isMatched {
                                // mostrar la carta texto
                                if card.isSignName {
                                    Text(card.sign.name)
                                        .font(.largeTitle)
                                        .frame(width: 100, height: 150)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                } else {
                                    //mostrar carta imagen
                                    Image(card.sign.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 150)
                                        .cornerRadius(10)
                                        .background(Color.white)
                                }
                            } else {
                                // carta boca abajo
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(10)
                            }
                        }
                        .onTapGesture {
                            flipCard(card)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            //fin de z stack
        }
        .onAppear {
            setupGame() // cuando la view aparece, empezar el juego
        }
    }
    //fin de body
}

//fin view
struct Juego2_Previews: PreviewProvider {
    static var previews: some View {
        Juego2View()
    }
}

