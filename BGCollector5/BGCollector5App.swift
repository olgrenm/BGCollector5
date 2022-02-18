//
//  BGCollector5App.swift
//  BGCollector5
//
//  Created by Michael Olgren on 1/17/22.
//

import SwiftUI

@main
struct BGCollector5App: App {
    let persistenceManager = PersistenceManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceManager.persistentContainer.viewContext)
                .onAppear {
                    addTestBGitems()
                }
        }
    }
    
    private func addTestBGitems() {
        let request = BGitem.fetchRequest()
        let context = PersistenceManager.shared.persistentContainer.viewContext
        do {
            if try context.count(for: request) == 0 {
                try BGitem.generateTestBGitems(in: context)
            }
        } catch {
            print("Error generating items: \(error)")
        }
    }
}
