//
//  LogginView.swift
//  Bluet
//
//  Created by Alumno on 17/10/24.
//

import SwiftUI

// estructura y usuarios "hardcodeados"
struct User {
    let username: String
    let password: String
}

//inicio de view
struct LoginView: View {
    let users = [
        User(username: "Usuario1", password: "1234"),
        User(username: "Javier", password: "abcd"),
        User(username: "Fran", password: "5678"),
        User(username: "Invitado", password: "1234"),
        User(username: "Denisse", password: "1234"),
        User(username: "Ale", password: "1234"),
    ]
    
    //variables de estado
    @State private var username = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var showLoadingScreen = false
    @State private var loginFailed = false

    @EnvironmentObject var userManager: UserManager
    //inicio de body
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.cyan)

                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .padding(.horizontal, 40)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .padding(.horizontal, 40)

                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                           startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }

                if loginFailed {
                    Text("Invalid username or password")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.purple, Color.blue]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            )
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showLoadingScreen) {
                LoadingScreenView(isAuthenticated: $isAuthenticated)
            }
        }
        .onAppear { print("login view") }
    }
    //fin de body
    func login() {
        print("func login")
        if let user = users.first(where: { $0.username == username && $0.password == password }) {
            userManager.login(username: user.username, password: user.password)
            loginFailed = false
            showLoadingScreen = true
            print("login failed = false")
        } else {
            print("login failed = true")
            loginFailed = true
        }
    }

}
//fin de view

//pantalla de carga
//inicio de view
struct LoadingScreenView: View {
    @Binding var isAuthenticated: Bool
    @EnvironmentObject var userManager: UserManager
    //inicio de body
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Cargando...")
                    .font(.title)
                    .foregroundColor(.white)
                // aqui va el progresso
                ProgressView()
                //un spinner ya pre hecho de swift
                    .progressViewStyle(CircularProgressViewStyle(tint: .cyan))
                    .scaleEffect(2)
                    .padding(.top, 20)
            }
        }

        .onAppear {
            print("loading view")
            // simula esperar a que cargue antes de pasar a pantalla principal
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("setting is auth to true")
                isAuthenticated = true
            }
        }
        .fullScreenCover(isPresented: $isAuthenticated) {
            ContentView()
            // le pasamos la variable de entorno 
                .environmentObject(userManager)
        }
    }
}





// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserManager()) 
    }
}
