//
//  ProfileView.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/6/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var controller = ProfileController()
    
    @State private var email = ""
    @State private var password = ""
    @State private var showDeleteAlert = false  // Controls the alert

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if let user = controller.user {
                List {
                    Section {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundStyle(Color.green)
                                .frame(width: 75, height: 75)
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.fullname)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    
                    Section("General") {
                        HStack {
                            SettingsRow(imageName: "gear",
                                        title: "Version",
                                        tintColor: Color(.systemBlue))
                            
                            Spacer()
                            
                            Text("1.1.0")
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    Section("Account") {
                        Button {
                            controller.signOut()
                        } label: {
                            SettingsRow(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out",
                                        tintColor: Color(.red))
                        }
                        // Delete Account button triggers the alert
                        Button {
                            showDeleteAlert = true
                        } label: {
                            SettingsRow(imageName: "xmark.circle.fill",
                                        title: "Delete Account",
                                        tintColor: Color.red)
                        }
                            }
                        }
                        .alert("Are you sure?", isPresented: $showDeleteAlert) {
                            Button("Delete", role: .destructive) {
                                Task {
                                    try await controller.deleteAccount(email: email, password: password)
                                }
                            }
                            Button("Cancel", role: .cancel) { }
                        } message: {
                            Text("This action cannot be undone.")
                        }
            } else {
                Text("Loading ...")
            }
        }
        .onAppear {
            controller.fetchUser()
        }
    }
}

#Preview {
    ProfileView()
}
