//
//  ProfileView.swift
//  Bluet
//
//  Created by Alumno on 17/10/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showLoginScreen = false
    @State private var showEditProfileModal = false
    @State private var selectedStats: [String: Bool] = [
        "Lecciones": true,
        "Dias": true,
        "Racha": true,
        "Racha más larga": false,
        "Lección repetida más veces": false,
        "Mejor tiempo de respuesta": false
    ]

    var body: some View {
        ZStack {
            // fondo con gradiante neon
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple, Color.blue, Color.pink]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                // foto de perfil
                ZStack {
                    Image("profile_picture")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
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

                // texto usuario
                Text(userManager.currentUser?.username ?? "Invitado")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.cyan)
                    .shadow(color: Color.purple, radius: 5, x: 0, y: 0)

                // texto para la descripcion
                Text("Texto prueba pra tener aqui el espacio")
                    .font(.body)
                    .foregroundColor(Color.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer().frame(height: 20)

                // stack de stats
//                VStack(spacing: 20) {
//                    if selectedStats["Lecciones"] == true {
//                        ProfileStatView(statName: "Lecciones", statValue: "114", glowColor: .pink)
//                    }
//                    if selectedStats["Dias"] == true {
//                        ProfileStatView(statName: "Dias", statValue: "100", glowColor: .green)
//                    }
//                    if selectedStats["Racha"] == true {
//                        ProfileStatView(statName: "Racha", statValue: "21", glowColor: .cyan)
//                    }
//                    if selectedStats["Racha más larga"] == true {
//                        ProfileStatView(statName: "Racha más larga", statValue: "45", glowColor: .orange)
//                    }
//                    if selectedStats["Lección repetida más veces"] == true {
//                        ProfileStatView(statName: "Lección repetida más veces", statValue: "10", glowColor: .purple)
//                    }
//                    if selectedStats["Mejor tiempo de respuesta"] == true {
//                        ProfileStatView(statName: "Mejor tiempo de respuesta", statValue: "5s", glowColor: .yellow)
//                    }
//                }

                // seleccion de stats pero scrolleable
                 ScrollView {
                     VStack(spacing: 20) {
                         if selectedStats["Lecciones"] == true {
                             ProfileStatView(statName: "Lecciones", statValue: "114", glowColor: .pink)
                         }
                         if selectedStats["Dias"] == true {
                             ProfileStatView(statName: "Dias", statValue: "100", glowColor: .green)
                         }
                         if selectedStats["Racha"] == true {
                             ProfileStatView(statName: "Racha", statValue: "21", glowColor: .cyan)
                         }
                         if selectedStats["Racha más larga"] == true {
                             ProfileStatView(statName: "Racha más larga", statValue: "45", glowColor: .orange)
                         }
                         if selectedStats["Lección repetida más veces"] == true {
                             ProfileStatView(statName: "Lección repetida más veces", statValue: "10", glowColor: .purple)
                         }
                         if selectedStats["Mejor tiempo de respuesta"] == true {
                             ProfileStatView(statName: "Mejor tiempo de respuesta", statValue: "5s", glowColor: .yellow)
                         }
                     }
                 }
                 .frame(maxHeight: 250)
                
                Spacer().frame(height: 50)

                // bottones custome dentro de hstack
                HStack(spacing: 40) {
                    NeonButtonView(buttonText: "Editar", gradient: [Color.blue, Color.purple], action: {
                        showEditProfileModal = true
                    })
                    NeonButtonView(buttonText: "Cerrar", gradient: [Color.red, Color.orange], action: {
                        showLoginScreen = true
                    })
                }
            }
            .padding()
            .sheet(isPresented: $showEditProfileModal) {
                StatSelectionView(selectedStats: $selectedStats) // Present the stat selection view
            }
            .fullScreenCover(isPresented: $showLoginScreen) {
                LoginView()
            }
        }
    }
}

// componente reutilizable de las estadisticas del usuario
struct ProfileStatView: View {
    var statName: String
    var statValue: String
    var glowColor: Color
    
    var body: some View {
        VStack {
            Text(statValue)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(glowColor)
                .shadow(color: glowColor, radius: 10, x: 0, y: 0)
            
            Text(statName)
                .font(.caption)
                .foregroundColor(Color.white.opacity(0.7))
        }
    }
}

// componentes reutilizables que sirven de bottones
struct NeonButtonView: View {
    var buttonText: String
    var gradient: [Color]
    var action: () -> Void = {} // defalt a vacio para evitar errores

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(buttonText)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(width: 140, height: 50)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: gradient),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(15)
                .shadow(color: gradient.last!.opacity(0.8), radius: 10, x: 0, y: 5)
                .shadow(color: gradient.first!.opacity(0.8), radius: 10, x: 0, y: -5)
        }
    }
}

struct StatSelectionView: View {
    @Binding var selectedStats: [String: Bool]
    @Environment(\.dismiss) var dismiss
    
    let availableStats = [
        "Lecciones",
        "Dias",
        "Racha",
        "Racha más larga",
        "Lección repetida más veces",
        "Mejor tiempo de respuesta"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Selecciona lo que te gustaria que aparezca en tu perfil")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(color: Color.blue.opacity(0.7), radius: 5, x: 0, y: 3)
                .padding(.top, 20)

            // la caja en si
            VStack(spacing: 15) {
                ForEach(availableStats, id: \.self) { statName in
                    Toggle(isOn: Binding(
                        get: { selectedStats[statName] ?? false },
                        set: { selectedStats[statName] = $0 }
                    )) {
                        Text(statName)
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .cyan))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(20)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.cyan.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .cornerRadius(20)
                    .shadow(color: Color.cyan.opacity(0.6), radius: 15, x: 0, y: 10)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.cyan.opacity(0.5), lineWidth: 2)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
            )
            .padding()

            Spacer()

            Button(action: {
                dismiss() // botton que cierra
            }) {
                Text("Listo")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(Color.black.opacity(0.9).ignoresSafeArea()) // Dim the background for focus
    }
}




// preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserManager())
    }
}
