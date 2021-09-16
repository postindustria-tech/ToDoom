//
//  ProjectsView.swift
//  ToDoom
//
//  Created by Paul Dmitryev on 27.08.2021.
//

import Combine
import SwiftUI


struct ProjectsView: View {
    @StateObject var dataManager: DataManager

    @State private var editingItem: UUID?
    @State private var selectedItem: Project?
    @State private var editTitle: String = ""
    @State private var newTitle: String = ""

    private var showItemsList: Binding<Bool> {
        .init {
            selectedItem != nil
        } set: { val in
            if !val {selectedItem = nil}
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: todoView,
                               isActive: showItemsList) {
                    EmptyView()
                }

                TextField("New project", text: $newTitle, onCommit: {
                    withAnimation {
                        dataManager.addProject(withName: newTitle)
                        newTitle = ""
                    }
                })

                Divider()
                    .padding(.bottom)

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(dataManager.projects) { project in
                            Group {
                                if editingItem == project.id {
                                    HStack {
                                        TextField("", text: $editTitle, onCommit: {
                                            withAnimation {
                                                editingItem = nil
                                                dataManager.updateProject(id: project.id, toName: editTitle)
                                            }
                                        })

                                        Spacer()

                                        Button {
                                            withAnimation {
                                                dataManager.removeProject(id: project.id)
                                            }
                                        } label: {
                                            Image(systemName: "trash.circle")
                                                .foregroundColor(.red)
                                        }
                                    }
                                } else {
                                    HStack {
                                        Text(project.name)
                                        Spacer()
                                        let (incomplete, total) = dataManager.todosCount(inProject: project)

                                        CountsView(first: total, second: incomplete)
                                        Image(systemName: "chevron.right")
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectedItem = project
                                    }
                                    .onLongPressGesture {
                                        withAnimation {
                                            editTitle = project.name
                                            editingItem = project.id
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)

                            Divider()
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Projects")
        }
    }

    @ViewBuilder var todoView: some View {
        if let project = selectedItem {
            TodosView(title: project.name,
                      todos: Binding(get: { dataManager.todos[project] ?? [] },
                                     set: { dataManager.todos[project] = $0 }))
        } else {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView(dataManager: .init(addingStubs: true))
    }
}

