//
//  ContentView.swift
//  TaskMaster
//
//  Created by Christian Altamura on 5/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var controller = ContentController()
    
    var body: some View {
        NavigationView {
        if controller.isSignedIn, !controller.currentUserId.isEmpty {
            TabView {
                ToDoListView(userId: controller.currentUserId)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        } else {
            LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
