//
//  ListViewModel.swift
//  BGCollector5
//
//  Created by Michael Olgren on 1/17/22.
//

import CoreData
import SwiftUI

struct ListViewModel {
    func deleteItem(
        for indexSet: IndexSet,
        section: FetchedResults<BGitem>,
        viewContext: NSManagedObjectContext
    ){
        indexSet.map { section[$0] }.forEach(viewContext.delete)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
