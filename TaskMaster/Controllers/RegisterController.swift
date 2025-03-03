//
//  RegisterController.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/4/24.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterController: ObservableObject {
    @Published var fullname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var error = ""
    
    init () {}
    
    func register() {
        error = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty &&
                !password.trimmingCharacters(in: .whitespaces).isEmpty &&
                !fullname.trimmingCharacters(in: .whitespaces).isEmpty else {
            error = "Please fill in all fields."
            return
        }
        
        guard email.contains("@") && email.contains(".") else {
            error = "Must be a valid email."
            return
        }
        
        guard password.count >= 12 else {
            error = "Password must be longer than 12 characters."
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.createUserRecord(id: userId)
            
            
        }
        print("Valid Entry")
    }
    
    private func createUserRecord(id: String) {
        let newUser = User(id: id,
                           fullname: fullname,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
}
