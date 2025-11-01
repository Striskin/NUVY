import SwiftUI

// JuegosView defines a view where the user can select a game to play.
struct JuegosView: View {
    
    @EnvironmentObject var userManager: UserManager

    // Define the grid layout with two columns.
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    // List of games available.
    let games = [
        Game(name: "Juego 1", destination: AnyView(Juego1View())),
        Game(name: "Juego 2", destination: AnyView(Juego2View())),
        Game(name: "Juego 3", destination: AnyView(Juego3View()))
    ]

    var body: some View {
        ZStack {
            // Light blue background that covers the entire screen.
            Color(red: 173/255, green: 216/255, blue: 230/255)
                .ignoresSafeArea()
            
            Image("fondo")
                .resizable()
                .ignoresSafeArea()
            
            // VStack containing the welcome header and the grid of games.
            VStack {
                
                // Header section welcoming the user.
                HStack {
                    Text("Bienvenid@ \(userManager.currentUser?.username ?? "invitado"), elige un juego para comenzar")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.teal]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .padding()
                    
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(LinearGradient(
                                    gradient: Gradient(colors: [Color.cyan, Color.pink]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ), lineWidth: 5)
                                .shadow(color: Color.cyan.opacity(0.8), radius: 10, x: 0, y: 0)
                        )
                        .shadow(color: Color.pink.opacity(0.6), radius: 20, x: 0, y: 0)
                }
                
                // Text label for the games section.
                Text("Aquí están los juegos:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 173/255, green: 216/255, blue: 230/255), // Light Blue
                                                        Color(red: 0/255, green: 105/255, blue: 148/255)]), // Dark Blue
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // LazyVGrid to display the games.
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(games) { game in
                        GameButtonView(game: game) // No need to wrap in NavigationLink here
                    }
                }
                .padding()

                Spacer()
            }
            .padding()
        }
        .navigationTitle("")
    }
}

// Model for a game with a name and a destination view.
struct Game: Identifiable {
    let id = UUID()
    let name: String
    let destination: AnyView
}

// GameButtonView represents the layout of each button associated with a game and handles navigation.
struct GameButtonView: View {
    var game: Game

    @State private var isPressed = false

    var body: some View {
        NavigationLink(destination: game.destination) { // Use NavigationLink inside GameButtonView
            ZStack {
                Color.gray
                    .frame(width: 150, height: 100)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 10)
                    .shadow(color: Color.black.opacity(isPressed ? 0.2 : 0.4), radius: 10, x: 0, y: isPressed ? 2 : 10)
                    .scaleEffect(isPressed ? 0.97 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isPressed)

                // Game name text overlay
                Text(game.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        isPressed = true
                        print("button pressed testing")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isPressed = false
                        }
                    }
            )
            .buttonStyle(PlainButtonStyle())
        }
    }
}

// Placeholder views for Juego1, Juego2, and Juego3.
//struct Juego1View: View {
//    var body: some View {
//        Text("Juego 1 View")
//    }
//}
//
//struct Juego2View: View {
//    var body: some View {
//        Text("Juego 2 View")
//    }
//}
//
//struct Juego3View: View {
//    var body: some View {
//        Text("Juego 3 View")
//    }
//}

// Preview for the JuegosView.
struct JuegosView_Previews: PreviewProvider {
    static var previews: some View {
        JuegosView()
            .environmentObject(UserManager())
    }
}
