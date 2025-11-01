//
//  CostomeTabView.swift
//  Bluet
//
//  Created by Alumno on 16/10/24.
//

import SwiftUI

// Reusable TabView Component
struct CustomTabView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            // Tab 1
            Button(action: {
                selectedTab = 0
            }) {
                VStack {
                    Image(systemName: "house.fill")
                        .font(.system(size: 24))
                    Text("Inicio")
                        .font(.caption)
                }
                .padding()
                .foregroundColor(selectedTab == 0 ? .blue : .gray)
            }

            Spacer()

            // Tab 2
            Button(action: {
                selectedTab = 1
            }) {
                VStack {
                    Image(systemName: "book.fill")
                        .font(.system(size: 24))
                    Text("Aprender2")
                        .font(.caption)
                }
                .padding()
                .foregroundColor(selectedTab == 1 ? .blue : .gray)
            }

            Spacer()

            // Tab 3
            Button(action: {
                selectedTab = 2
            }) {
                VStack {
                    Image(systemName: "gamecontroller.fill")
                        .font(.system(size: 24))
                    Text("Juegos")
                        .font(.caption)
                }
                .padding()
                .foregroundColor(selectedTab == 2 ? .blue : .gray)
            }

            Spacer()

            // Tab 4
            Button(action: {
                selectedTab = 3
            }) {
                VStack {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 24))
                    Text("Configuración")
                        .font(.caption)
                }
                .padding()
                .foregroundColor(selectedTab == 3 ? .blue : .gray)
            }
        }
        .padding()
        .background(Color.white.shadow(radius: 10))
    }
}
