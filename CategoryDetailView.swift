import SwiftUI

//inicio de view
struct CategoryDetailView: View {
    var category: Category // The selected category
    @State private var selectedLesson: Lesson? = nil
    
    //inicio body
//    var body: some View {
//        ZStack {
//            // color de fondo "flat"
//            Color(red: 173/255, green: 216/255, blue: 230/255)
//                .ignoresSafeArea()
//            
//            Image("fondo")
//                .resizable() // Make the image resizable
////                .scaledToFill() // Scale the image to fill the entire space
//                .ignoresSafeArea()
//
//            VStack {
//                
//                GeometryReader { geometry in
//                    Image(category.imageName)
//                        .resizable()
//                        .scaledToFit()
//                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(15)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.white, lineWidth: 2)
//                        )
//                        //.border(Color.black, width: 1)
//                        //.shadow(radius: 20)
//                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5) // Soft shadow
//
//                        .background(Color.white)
//                        //.addBorder(cornerRadius: 10)
//                        .cornerRadius(20)
//                        //.clipShape(.buttonBoarder)
//                        .frame(width: geometry.size.width * 1) // 80%
//                }
//                
//                // lecciones de ...
//                Text("Lecciones de \(category.name)")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding()
//
//// 
//                // lista de lecciones
////                List {
////                    ForEach(category.lessons) { lesson in
////                        NavigationLink(destination: destinationView(for: lesson)) {
////
////                            HStack {
////                                Text(lesson.title)
////                                    .font(.headline)
////                                    .foregroundColor(.primary)
////                                    .padding()
////                                
////                                ProgressView(value: 0.5)
////                                    .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
////                            }
////                            .frame(maxWidth: .infinity)
////                            .padding()
////                            .background(Color.white.opacity(0.7)) // Semi-transparent white background
////                            .cornerRadius(10)
////                            .shadow(radius: 5) // Shadow for each list item
////                            .overlay(
////                                RoundedRectangle(cornerRadius: 10)
////                                    .stroke(Color.blue.opacity(0.7), lineWidth: 2) // Blue border
////                            )
////                        }
////                        .listRowBackground(Color.clear) // Clear background to show the blue behind
////                        .padding(.vertical, 5) // Vertical padding between items
////                    }
////                }
////                
//                // fondo de toda la lista
//                .background(Color.blue.opacity(0.7))
//                .scrollContentBackground(.hidden) // quita el default?
//                .listStyle(PlainListStyle()) // "plain" list
//                .padding(.horizontal)
//                Spacer()
//            }
//            .padding()
//            Spacer()
//        }
//        .navigationTitle(category.name)
//    }
    //fin de body
    
    var body: some View {
        ZStack {
            // Color de fondo "flat"
            Color(red: 173/255, green: 216/255, blue: 230/255)
                .ignoresSafeArea()
            
            Image("fondo")
                .resizable()
                .ignoresSafeArea()

            VStack {
//                GeometryReader { geometry in
//                    Image(category.imageName)
//                        .resizable()
//                        .scaledToFit()
//                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(15)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.white, lineWidth: 2)
//                        )
//                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
//                        .background(Color.white)
//                        .cornerRadius(20)
//                        .frame(width: geometry.size.width * 1) // 100% width
                    GeometryReader { geometry in
                        // hacer el display de la imagen o la predeterminada
                        if let imageName = category.imageName {
                            Image(imageName) // Custom image
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                                .background(Color.black)
                                .cornerRadius(20)
                                .frame(width: geometry.size.width * 1)
                        } else if let systemImageName = category.systemImageName {
                            Image(systemName: systemImageName) // imagen default de sistema
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.pink.opacity(0.9)) // color de la imagen de sistema
                                .cornerRadius(15)
                                .padding()
                                .background(Color.blue.opacity(0.3)) // Optional background for system icon
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                                .frame(width: geometry.size.width * 1)
                        }
                }
                
                Text("Lecciones de \(category.name)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                // zstack para toda la lista
                ZStack {
                    // rectangulo container para la lista
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.7))
                        .shadow(radius: 5)
                    
                    List {
                        ForEach(category.lessons) { lesson in
                            NavigationLink(destination: destinationView(for: lesson)) {

                                HStack {
                                    Text(lesson.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding()

                                    ProgressView(value: 0.5)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                                )
                            }
                            .listRowBackground(Color.clear) // fondo de cada item
                            .padding(.vertical, 5) // padding vertical entre cada item
                        }
                    }
                    .scrollContentBackground(.hidden) // remueve background default (?)
                    .listStyle(PlainListStyle())
                    .padding(.all) // padding dentro de lista para estilo
                }
                .padding(.horizontal) // para separar de los bordes laterales y que se vea centrado
                Spacer() //como un content space around de css
            }
            .padding()
        }
        .navigationTitle(category.name)
    }

    
    // funcion helper
    @ViewBuilder
    func destinationView(for lesson: Lesson) -> some View {
        //print("Navigating to view for lesson title: \(lesson.title)")

        switch lesson.title {
        case "Juego 1":
            Juego1View()
        case "Juego 2":
            Juego2View()
        case "Juego 3":
            Juego3View()
        case "Lección 1: Frutas":
            LessonView(lesson: lesson)
        default:
            Text("Vista no encontrada")
        }
    }
}
//fin de view

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let sampleLessons = [
            Lesson(title: "Lección 1: Frutas", videoName: "VIDEO_FRUTAS", transcription: "Transcripción de la lección 1"),
            Lesson(title: "Juego 2", videoName: "", transcription: "")

        ]
        
        
        let sampleCategory = Category(name: "Comida", imageName: nil,systemImageName: "fork.knife", lessons: sampleLessons)
        
        NavigationView {
            CategoryDetailView(category: sampleCategory)
        }
    }
}
