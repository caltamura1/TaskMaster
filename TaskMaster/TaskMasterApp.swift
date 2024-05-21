//
//  TaskMasterApp.swift
//  TaskMaster
//
//  Created by Christian Altamura on 5/21/24.
//

import SwiftUI
import FirebaseCore

@main
struct TaskMasterApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
