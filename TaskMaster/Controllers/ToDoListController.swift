//
//  ToDoListController.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/6/24.
//

import FirebaseFirestore
import Foundation

import FirebaseFirestore
import Foundation

class ToDoListController: ObservableObject {
    @Published var showingNewItemView = false
    private let userId: String

    init(userId: String) {
        self.userId = userId
    }

    func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("tasks")
            .document(id)
            .delete()
    }

    func move(from source: IndexSet, to destination: Int) {
        let db = Firestore.firestore()
        
        // Fetch the items sorted by `orderIndex`
        db.collection("users")
            .document(userId)
            .collection("tasks")
            .order(by: "orderIndex")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }

                // Convert Firestore documents into an array of (taskID, orderIndex)
                var orderedItems = documents.compactMap { document -> (String, Int)? in
                    let id = document.documentID
                    let orderIndex = document["orderIndex"] as? Int ?? 0
                    return (id, orderIndex)
                }
                
                // Perform local reordering
                orderedItems.move(fromOffsets: source, toOffset: destination)
                
                // Update Firestore with new order
                for (index, item) in orderedItems.enumerated() {
                    db.collection("users")
                        .document(self.userId)
                        .collection("tasks")
                        .document(item.0) // item.0 is the task's ID
                        .updateData(["orderIndex": index])
                }
            }
    }
}
