//
//  Untitled.swift
//  Bluet
//
//  Created by Alumno on 14/10/24.
//

import SwiftUI

//inicio de view
struct SettingsView: View {
    @State private var soundEnabled = true
    @State private var notificationsEnabled = false
    @State private var volume: Double = 50
    
    //inicio de body
    var body: some View {
        NavigationStack {
            //inicio z stack
            ZStack {
                // fondo con gradiante de prueba
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Text("Configuración")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                    
                    Spacer()
                    
                    // sonido
                    Toggle(isOn: $soundEnabled) {
                        Text("Sonido")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.green))
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    
                    // notificaciones
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Notificaciones")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    
                    // volumen
                    VStack(alignment: .leading) {
                        Text("Volumen")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Slider(value: $volume, in: 0...100)
                            .accentColor(.purple)
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    // botton de guardar
                    Button(action: {
                        //aqui implementariamos el guardado
                    }) {
                        Text("Guardar")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 220, height: 60)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    //fin de botton
                    Spacer()
                }
                .padding(.horizontal)
            }
            //fin z stack
            .navigationTitle("")
        }
    }
    //fin de body
}
//fin de view

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
