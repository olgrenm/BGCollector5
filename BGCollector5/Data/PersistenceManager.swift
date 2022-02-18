//
//  PersistenceManager.swift
//  BGCollector5
//
//  Created by Michael Olgren on 1/17/22.
//

import CoreData

struct PersistenceManager {
    static let shared = PersistenceManager()
    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "Stash")
        if inMemory,
           let storeDescription = persistentContainer.persistentStoreDescriptions.first {
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores {_, error in
            if let error = error as NSError? {
                fatalError("Unable to configure Core Data Store: \(error), \(error.userInfo)")
            }
        }
    }
    
    static var preview: PersistenceManager = {
        let result = PersistenceManager(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        for bgItemNumber in 0..<5 {
            let newBGitem = BGitem(context: viewContext)
            newBGitem.name = "BGitem \(bgItemNumber)"
            newBGitem.type = "quest"
            newBGitem.action = "Test action \(bgItemNumber)"
            newBGitem.reward = "Test reward \(bgItemNumber)"
            newBGitem.area = "Test area AR\(bgItemNumber)"
            newBGitem.location = "Test location \(bgItemNumber)"
            newBGitem.subArea = "Test sub-area \(bgItemNumber)"
            newBGitem.isDone = false
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
