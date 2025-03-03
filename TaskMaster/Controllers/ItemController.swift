//
//  ItemController.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/6/24.
//

import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth
import Foundation

class ItemController: ObservableObject {
    @Published var title = ""
    
    init() {}
    
    func save() {
        guard !title.isEmpty else { return }
        
        guard let uId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        // Get the highest current orderIndex
        db.collection("users").document(uId).collection("tasks")
            .order(by: "orderIndex", descending: true)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                let maxIndex = snapshot?.documents.first?["orderIndex"] as? Int ?? 0
                let newId = UUID().uuidString
                
                let newItem = ToDoListItem(
                    id: newId,
                    title: self.title,
                    isDone: false,
                    orderIndex: maxIndex + 1  // Set orderIndex incrementally
                )
                
                db.collection("users")
                    .document(uId)
                    .collection("tasks")
                    .document(newId)
                    .setData(newItem.asDictionary())
            }
    }

}
