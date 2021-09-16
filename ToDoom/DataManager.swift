//
//  DataManager.swift
//  ToDoom
//
//  Created by Paul Dmitryev on 27.08.2021.
//

import Foundation

struct Project: Identifiable, Hashable {
    let id = UUID()
    var name: String
}

extension Project: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.name = value
    }
}

struct TodoItem: Identifiable {
    let id = UUID()
    var text: String
    var completed: Date? = nil

    var isCompleted: Bool {
        get { completed != nil }
        mutating set { completed = newValue ? Date() : nil }
    }
}

extension TodoItem: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.text = value
    }
}

class DataManager: ObservableObject {
    @Published var todos: [Project: [TodoItem]] = [:]

    var projects: [Project] {
        todos.keys.sorted { $0.name < $1.name }
    }

    init(addingStubs: Bool = false) {
        if addingStubs {
            todos = [
                "Wash cat": ["Buy shampoo", "Drink for courage", "Try to do that", "Treat wounds"],
                "Water flowers": [],
                "Soak socks": ["They aren't the cat!", "It's a huge relief"]
            ]
        }
    }

    func todosCount(inProject: Project) -> (Int, Int) {
        guard let items = todos[inProject] else {
            return (0, 0)
        }
        return (items.filter({ !$0.isCompleted }).count, items.count)
    }

    func updateProject(id: UUID, toName: String) {
        if var item = todos.keys.first(where: { $0.id == id}) {
            let values = todos.removeValue(forKey: item)
            item.name = toName
            todos[item] = values
        }
    }

    func addProject(withName: String) {
        guard !withName.isEmpty else {
            return
        }
        todos[Project(name: withName)] = []
    }

    func removeProject(id: UUID) {
        if let item = todos.keys.first(where: { $0.id == id}) {
            todos.removeValue(forKey: item)
        }
    }
}
