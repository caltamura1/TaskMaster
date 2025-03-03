//
//  ToDoListView.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/5/24.
//

import FirebaseFirestoreSwift
import SwiftUI

import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var controller: ToDoListController
    @FirestoreQuery var items: [ToDoListItem]  // Firestore Query Variable
    
    private let userId: String

    // Correcting FirestoreQuery usage inside the initializer
    init(userId: String) {
        self.userId = userId
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/tasks",
            predicates: [.order(by: "orderIndex", descending: false)] // Correct Firestore sorting syntax
        )
        self._controller = StateObject(wrappedValue: ToDoListController(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        LineItemView(item: item)
                            .swipeActions {
                                Button("Delete") {
                                    if let itemId = item.id {
                                        controller.delete(id: itemId)
                                    }
                                }
                                .tint(Color.red)
                            }
                    }
                    .onMove(perform: controller.move) // Enables drag-and-drop reordering
                }
                .toolbar {
                    EditButton() // Enables reordering mode
                    Button {
                        controller.showingNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Thing Check")
            .sheet(isPresented: $controller.showingNewItemView) {
                ItemView(newItemPresented: $controller.showingNewItemView)
            }
        }
    }
}

#Preview {
    ToDoListView(userId: "gGe8aacCWhgQqYZl1vlTE0RdBP22")
}
