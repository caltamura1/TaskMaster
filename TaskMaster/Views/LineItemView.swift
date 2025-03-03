//
//  ItemLineView.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/9/24.
//

import SwiftUI

struct LineItemView: View {
    @StateObject var controller = LineItemController()
    let item: ToDoListItem
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(item.title)
                    .bold()
            }
            Spacer()
            
            Button {
                controller.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
            }
            .foregroundColor(Color.green)
        }
    }
}

//#Preview {
//    LineItemView(item: .init(id: "123456789", title: "Complete Application", isDone: true))
//}
