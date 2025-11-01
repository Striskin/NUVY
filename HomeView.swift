//
//  HomeView.swift
//  Bluet
//
//  Created by Alumno on 20/10/24.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            BackgroundImageView()
            ButtonGroupView()
                .padding(.bottom, 60)
        }
    }
}

struct BackgroundImageView: View {
    var body: some View {
        Image("fondo")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

struct ButtonGroupView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("")
                .padding(.top, 200)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(radius: 5)
            
            Spacer()
            
            NavigationLink(destination: LearnView()) {
                CustomButtonView(title: "Aprender", colors: [Color.orange, Color.yellow])
            }
            
//            NavigationLink(destination: CategoryDetailView(category: gameCategory)) {
//                CustomButtonView(title: "Juegos", colors: [Color.green, Color.teal])
//            }
            
            NavigationLink(destination: JuegosView()) {
                CustomButtonView(title: "Juegos", colors: [Color.green, Color.teal])
            }
            
            NavigationLink(destination: SettingsView()) {
                CustomButtonView(title: "Configuración", colors: [Color.blue, Color.purple])
            }
            
            Spacer()
        }
    }
}

struct CustomButtonView: View {
    let title: String
    let colors: [Color]
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(width: 220, height: 60)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(.white)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 2)
            )
            .shadow(radius: 5)
    }
}
