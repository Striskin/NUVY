//
//  Bluet3App.swift
//  Bluet3
//
//  Created by Alumno on 23/10/24.
//

//import SwiftUI
//
//@main
//struct Bluet3App: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

import SwiftUI

@main
struct Bluet3App: App {
    @StateObject private var userManager = UserManager()

    var body: some Scene {
        WindowGroup {
            if userManager.isAuthenticated {
                ContentView()
                    .environmentObject(userManager) // Inject UserManager here
            } else {
                LoginView()
                    .environmentObject(userManager) // Inject UserManager here
            }
        }
    }
}
