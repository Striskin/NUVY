//
//  UserManager.swift
//  Bluet
//
//  Created by Alumno on 18/10/24.
//

import Combine
import SwiftUI

class UserManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUsername: String?
    @Published var currentUser: User?


    var isAuthenticated: Bool {
        return isLoggedIn && currentUsername != nil
    }

//    func login(username: String, password: String) {
//        print("User logged in: \(self.currentUser?.username ?? "No user")")
//
//        self.currentUsername = username
//        self.isLoggedIn = true
//        self.currentUser = User(username: username, password: password)
//        print("in user manager, user after attempting to set: \(String(describing: currentUser?.username)) ")
//
//    }
    
    // Custom initializer to accept a user
     init(currentUser: User? = nil) {
         self.currentUser = currentUser
         self.isLoggedIn = currentUser != nil
         self.currentUsername = currentUser?.username
     }
    
    func login(username: String, password: String) {
        self.currentUser = User(username: username, password: password)
        self.isLoggedIn = true
        self.currentUsername = username

    }

    // regresar las variables a vacio cuando se salga el usuario
    func logout() {
        self.currentUsername = nil
        self.isLoggedIn = false
        self.currentUser = nil
    }
}


