//
//  TodosView.swift
//  ToDoom
//
//  Created by Paul Dmitryev on 27.08.2021.
//

import SwiftUI

struct TodosView: View {
    let title: String

    @Binding var todos: [TodoItem]

    @State var newItem: String = ""

    var body: some View {
        VStack {
            TextField("New item", text: $newItem, onCommit: {
                todos.append(.init(text: newItem))
                newItem = ""
            })
                .padding(.bottom, 16)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(todos) { item in
                        Button {
                            if let idx = todos.firstIndex(where: { $0.id == item.id }) {
                                todos[idx].isCompleted.toggle()
                            }
                        } label: {
                            Text(item.text)
                                .foregroundColor(item.isCompleted ? .secondary : .primary)
                                .strikethrough(item.isCompleted)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Divider()
                    }
                }
            }
            .font(.title)
        }
        .padding()
        .navigationTitle(title)
    }
}

struct TodosView_Previews: PreviewProvider {
    static var previews: some View {
        TodosView(title: "Test", todos: .constant(["Some", "Other", "View"]))
    }
}
