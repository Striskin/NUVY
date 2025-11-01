import SwiftUI

// Modelo de datos para representar una categoría.
//struct Category: Identifiable, Hashable {
//    var id = UUID()
//    var name: String
//    var imageName: String
//    var lessons: [Lesson]
//}
//
//struct Lesson: Identifiable, Hashable {
//    var id = UUID()
//    var title: String
//    var videoName: String 
//    var transcription: String
//}

// La estructura LearnView define una vista en la que el usuario puede seleccionar una categoría de aprendizaje.
//inicio del view
struct LearnView: View {
    
    @EnvironmentObject var userManager: UserManager 
    //creo que ya no se usa
//    @State private var selectedTab = 0

    // Definimos el layout para el grid, en este caso será un grid de 2 columnas.
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    // Lista de categorías disponibles.
//    let categories = [
//        Category(
//            name: "Comida",
//            imageName: "Comida",
//            lessons: [
//                Lesson(title: "Lección 1: Frutas", videoName: "frutas_video", transcription: "Transcripción de las frutas"),
//                Lesson(title: "Lección 2: Verduras", videoName: "verduras_video", transcription: "Transcripción de las verduras"),
//                Lesson(title: "Lección 3: Bebidas", videoName: "bebidas_video", transcription: "Transcripción de las bebidas")
//            ]
//        ),
//        Category(
//            name: "Animales",
//            imageName: "Animales",
//            lessons: [
//                Lesson(title: "Lección 1: Mamíferos", videoName: "mamiferos_video", transcription: "Transcripción de mamíferos"),
//                Lesson(title: "Lección 2: Aves", videoName: "aves_video", transcription: "Transcripción de aves")
//            ]
//        ),
//        Category(
//            name: "Colores",
//            imageName: "Colores",
//            lessons: [
//                Lesson(title: "Lección 1: primarios", videoName: "primarios", transcription: "Transcripción de primarios"),
//                Lesson(title: "Lección 2: secundarios", videoName: "secundarios", transcription: "Transcripción de secundarios")
//            ]
//        ),
//        Category(
//            name: "Trabajos",
//            imageName: "Trabajos",
//            lessons: [
//                Lesson(title: "Lección 1: Seguridad", videoName: "mano", transcription: "Transcripción de mano"),
//                Lesson(title: "Lección 2: Salud", videoName: "comunes", transcription: "Transcripción de comunes")
//            ]
//        ),
//    ]

    //inicio del body
    var body: some View {
        


        // ZStack permite superponer vistas una sobre otra. Aquí se usa para colocar el color de fondo debajo de los elementos.
        //inicio de zstack
        ZStack {
            // Fondo azul celeste, que ocupa toda la pantalla.
            Color(red: 173/255, green: 216/255, blue: 230/255)
                .ignoresSafeArea()
            
            Image("fondo")
                .resizable()
                .ignoresSafeArea()
            
            //inicio de vstack
            VStack {
                
                //header o bienvenida
                HStack{
                    Text("Bienvenid@ \(userManager.currentUser?.username ?? "invitado"), elige una categoría para continuar aprendiendo")


                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        //.cornerRadius(15) //incorrecto, el orden es importante
                        .padding() // agrgar este padding para que el fondo se ajuste
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.teal]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15) // este le aplica el borde al fondo
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .padding() // Outer padding if you want to add space around the card
                    

//                        Spacer() //probar
                    
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
                
//                Spacer()
                
                Image(systemName: "") // You can provide a valid system image name or placeholder text here.
                    .resizable() // Makes the image resizable
                    .scaledToFit() // Scales the image to fit within the available space while maintaining its aspect ratio
                    .frame(maxWidth: .infinity, maxHeight: 150) // Sets the max width to fill the screen and a specific height
                    .background(Color.white) // Adds a white background
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .cornerRadius(15) // Adds rounded corners
                    .padding(.horizontal, 16) // Adjust the padding to create space on the sides
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                Text("Aquí están las categorías:")
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

                
                
                // Aquí usamos LazyVGrid para organizar los botones en una rejilla.
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(categories) { category in
                    CategoryButtonView(category: category)
                }
                    //fin del foreach de lazyvgrid

            }
                //fin del grid
                .padding()

                Spacer()
            
        }
            //fin de vstack
            .padding()
           


        }
        //fin de zstack
        Spacer()
        // Define la navegación hacia la vista de detalle cuando se selecciona una categoría.
//            CustomTabView(selectedTab: $selectedTab)
//                .background(Color(UIColor.systemBackground))
        .navigationTitle("")

    }
//fin del body
}
//fin del view

// Componente reutilizable que representa el diseño de los botones de categoría con imagen y título superpuesto.
struct CategoryButtonView: View {
    var category: Category // Pass the whole category to navigate to the correct view

    @State private var isPressed = false

    var body: some View {
        NavigationLink(destination: CategoryDetailView(category: category)) {
            
            //zstack de las categorias
            ZStack {
                if let imageName = category.imageName {
                    // el nombre de la imagen en la carpeta de assets
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 150, height: 100)
                        .clipped()
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(radius: 10)
                        .shadow(color: Color.black.opacity(isPressed ? 0.2 : 0.4), radius: 10, x: 0, y: isPressed ? 2 : 10) // Shadow reduces when pressed
                        .scaleEffect(isPressed ? 0.97 : 1.0) // Scale reduces when pressed
                        .animation(.easeInOut(duration: 0.2), value: isPressed)
                    // si el anterior no esta disponible, pero hay systemImageName
                } else if let systemImageName = category.systemImageName {
                    Image(systemName: systemImageName)
                        .resizable()
//                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 100)
//                        .frame(width: geometry.size.width * 1)
                        .clipped()
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(radius: 10)
                        .shadow(color: Color.black.opacity(isPressed ? 0.2 : 0.4), radius: 10, x: 0, y: isPressed ? 2 : 10) // Shadow reduces when pressed
                        .scaleEffect(isPressed ? 0.97 : 1.0) // Scale reduces when pressed
                        .animation(.easeInOut(duration: 0.2), value: isPressed)
                    // caso que no existe ninguno de los dos
                } else {
                    
                    Color.gray
                        .frame(width: 150, height: 100)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(radius: 10)
                        .shadow(color: Color.black.opacity(isPressed ? 0.2 : 0.4), radius: 10, x: 0, y: isPressed ? 2 : 10) // Shadow reduces when pressed
                        .scaleEffect(isPressed ? 0.97 : 1.0) // Scale reduces when pressed
                        .animation(.easeInOut(duration: 0.2), value: isPressed)
                }

                // Category name text overlay
                Text(category.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
            }
            
            //dimensiones de zstack de categorias
            //.frame(width: 150, height: 100)
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    // logea el nombre de la view que deberia ser a la que se mande
                    print("Category Selected: \(category.name)")
                    isPressed = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isPressed = false
                    }
                }
        )
        .buttonStyle(PlainButtonStyle()) // Disable default button style to keep custom appearance

    }
}

//fin de componente botton
    
//inicio preview
struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
            .environmentObject(UserManager())
    }
}

//fin de preview
