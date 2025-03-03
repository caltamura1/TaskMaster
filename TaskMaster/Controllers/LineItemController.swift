//
//  LineItemController.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/9/24.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class LineItemController: ObservableObject {
    
    init() {}
    
    func toggleIsDone(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)

        guard let uId = Auth.auth().currentUser?.uid else { return }
        guard let itemId = itemCopy.id else { return }  // Safely unwrap itemCopy.id

        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("tasks")
            .document(itemId)  // Now using a safely unwrapped String
            .setData(itemCopy.asDictionary())
    }
}
