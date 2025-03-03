//
//  ProfileController.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/6/24.
//

//
//  AuthVM.swift
//  RollForDinner
//
//  Created by Christian Altamura on 3/27/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

class ProfileController: ObservableObject {
    init() {}
    
    @Published var user: User? = nil
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    fullname: data["fullname"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            return
        }
    }
    
    func deleteAccount(email: String, password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "AppError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No authenticated user found"])
        }
        
        do {
            // Optionally remove user data from Firestore first
            try await Firestore.firestore().collection("users").document(user.uid).delete()
            // Delete the user's authentication record
            try await user.delete()
            //Signout user to prevent account lock
            signOut()
            print("User account deleted successfully.")
        } catch let error as NSError {
            if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                switch errorCode {
                case .requiresRecentLogin:
                    // If reauthentication is needed, call reauthenticateUser
                    try await reauthenticateUser(email: email, password: password)
                    // Try to delete the user again after successful reauthentication
                    try await user.delete()
                    // sign out user to prevent account lock
                    signOut()
                    print("User account successfully deleted after re-authentication.")
                default:
                    print("Error deleting user: \(error.localizedDescription)")
                    throw error
                }
            } else {
                print("Error deleting user: \(error.localizedDescription)")
                throw error
            }
        }
    }
    
    func reauthenticateUser(email: String, password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "AppError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No authenticated user found"])
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        do {
            // Re-authenticate the user
            try await user.reauthenticate(with: credential)
            print("User re-authenticated successfully")
        } catch {
            print("Error re-authenticating user: \(error)")
            throw error
        }
    }
}
