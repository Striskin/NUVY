import SwiftUI

struct Sign: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct Juego1View: View {
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
    
    @State private var randomSigns: [Sign] = []
    @State private var shuffledImages: [Sign] = []
    @State private var selectedText: Sign? = nil
    @State private var selectedImage: Sign? = nil
    @State private var correctSign: Sign? = nil
    @State private var score: Int = 0
    @State private var isVisible = true
    @State private var showCorrectTick = false
    @State private var showIncorrectX = false

    @State private var startPoint: CGPoint? = nil
    @State private var endPoint: CGPoint? = nil

    // inicio
    func startGame() {
        withAnimation {
            isVisible = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

            randomSigns = signs.shuffled().prefix(3).map { $0 }
            correctSign = randomSigns.randomElement()
            
            var imageOptions: [Sign] = [correctSign!] // las opciones son las que en los signos no es la respuesta correcta
            // ahora los otros signos (nombres)
            let otherSigns = signs.filter { sign in !randomSigns.contains(where: { $0.id == sign.id }) }.shuffled() // Fix sacado de internet
            // agrega los 2 otros signos a las opciones de imagen
            imageOptions.append(contentsOf: otherSigns.prefix(2))
            //declara las imagenes revueltas a ser las possibles opciones usando metodo shuffle
            shuffledImages = imageOptions.shuffled()
            withAnimation {
                isVisible = true
            }
        }
    }

    // funcion checar si son pares
    func checkMatch() {
        if let selectedText = selectedText, let selectedImage = selectedImage {
            if selectedText.id == selectedImage.id {
                score += 1
                print("Correct! Score: \(score)")
                showCorrectTick = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showCorrectTick = false
                }
            } else {
                print("Incorrect")
                showIncorrectX = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showIncorrectX = false
                }
            }
            // resetea la seleccion de cartas
            startPoint = nil
            endPoint = nil
            self.selectedText = nil //variable de estado
            self.selectedImage = nil //variable de estado
            startGame() // reinicia el juego entero despues de la seleccion
        }
    }
//inicio body
    var body: some View {
        //inicio de z stack
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                
                Text("Elige la letra con la seña correcta: ")
                    .font(.largeTitle)
                    .padding()
                
                Text("Puntos: \(score)")
                    .font(.headline)
                    .padding()
                
                HStack {
                    // columna letras
                    VStack {
                        Text("Letras")
                            .font(.title2)
                            .padding()
                        
                        ForEach(randomSigns) { sign in
                            GeometryReader { geometry in
                                Text(sign.name)
                                    .font(.title2)
                                    .padding()
                                    .background(selectedText?.id == sign.id ? Color.green : Color.clear)
                                    .cornerRadius(10)
                                    .opacity(isVisible ? 1 : 0) // Control visibility
                                    .onTapGesture {
                                        selectedText = sign
                                        startPoint = CGPoint(x: geometry.frame(in: .global).midX, y: geometry.frame(in: .global).midY) // Set starting point
                                        checkMatch()
                                    }
                            }
                            .frame(height: 150)
                        }
                    }
                    // fin de columna de lettras
                    
                    Spacer() //espacio entre columnas
                    
                    // Columna signos
                    VStack {
                        Text("Signo")
                            .font(.title2)
                            .padding()
                        
                        ForEach(shuffledImages) { sign in
                            GeometryReader { geometry in
                                Image(sign.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .padding()
                                    .background(selectedImage?.id == sign.id ? Color.green : Color.clear)
                                    .cornerRadius(10)
                                    .opacity(isVisible ? 1 : 0) // Control visibility
                                    .onTapGesture {
                                        selectedImage = sign
                                        endPoint = CGPoint(x: geometry.frame(in: .global).midX, y: geometry.frame(in: .global).midY) // Set end point
                                        checkMatch()
                                    }
                            }
                            .frame(height: 150)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            
            // dibuja linea, wip
            if let start = startPoint, let end = endPoint {
                Path { path in
                    path.move(to: start)
                    path.addLine(to: end)
                }
                .stroke(Color.green, lineWidth: 3)
                .zIndex(1)
            }
            
            if showCorrectTick {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 100, height: 100)
                    .transition(.scale) // animacion de aparecer desaparecer
                    .zIndex(1) // z assegura que aparezca sobre otros elementos
            }
            
            // marca incorrecta
            if showIncorrectX {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 100, height: 100)
                    .transition(.scale)
                    .zIndex(1)
            }
        }
        //fin de z stack
        .onAppear {
            startGame() // inicia el juego cuando aparece la view
        }
    }
    //fin body
}

struct Juego1_Previews: PreviewProvider {
    static var previews: some View {
        Juego1View()
    }
}
