//
//  ItemView.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/6/24.
//

import SwiftUI

struct ItemView: View {
    @StateObject var controller = ItemController()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Text("Add Thing")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 20)
            
            Form {
                TextField("Thing Name", text: $controller.title)
                    .frame(height: 35)
                    .cornerRadius(8)
                HStack {
                    Button("Save") {
                        controller.save()
                        newItemPresented = false
                    }
                    .font(.headline)
                    .foregroundColor(Color.inverse)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
                    .opacity(controller.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1)
                    .disabled(controller.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .frame(height: 35)
            }
        }
    }
}

#Preview {
    ItemView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in }))
}
