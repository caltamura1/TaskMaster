//
//  AuthController.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/4/24.
//

import FirebaseAuth
import Foundation

class LoginController: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var error = ""
    
    init () {}
    
    func login() {
        error = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty &&
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            error = "Please fill in all fields."
            return
        }
        
        guard email.contains("@") && email.contains(".") else {
            error = "Must be a valid email."
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, err in
            if let err = err as NSError? {
                // Compare the integer error code to the rawValue of the error case.
                if err.code == AuthErrorCode.userNotFound.rawValue {
                    DispatchQueue.main.async {
                        self?.error = "No login is found"
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.error = "No login is found"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.error = ""
                    print("Valid Entry")
                }
            }
        }
    }
    
    // New resetPassword function
        func resetPassword() {
            error = ""
            guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
                error = "Please enter your email address."
                return
            }
            
            Auth.auth().sendPasswordReset(withEmail: email) { [weak self] err in
                DispatchQueue.main.async {
                    if let err = err {
                        self?.error = err.localizedDescription
                    } else {
                        self?.error = "Password reset email sent."
                    }
                }
            }
        }
    }


