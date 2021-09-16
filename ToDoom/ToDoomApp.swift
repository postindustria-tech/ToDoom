//
//  ToDoomApp.swift
//  ToDoom
//
//  Created by Paul Dmitryev on 27.08.2021.
//

import SwiftUI

struct Dependencies {
    static let shared = Dependencies()

    let dataManager = DataManager(addingStubs: true)
}

@main
struct ToDoomApp: App {
    var body: some Scene {
        WindowGroup {
            ProjectsView(dataManager: Dependencies.shared.dataManager)
        }
    }
}
