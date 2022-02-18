//
//  AddBGitemViewModel.swift
//  BGCollector5
//
//  Created by Michael Olgren on 1/17/22.
//

import CoreData

struct AddBGitemViewModel {
    func fetchBGitem(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> BGitem? {
        guard let bgItem = context.object(with: objectId) as? BGitem else {
            return nil
        }
        
        return bgItem
    }
    
    func saveBGitem(
        bgItemId: NSManagedObjectID?,
        with bgItemValues: BGitemValues,
        in context: NSManagedObjectContext
    ){
        let bgItem: BGitem
        if let objectId = bgItemId,
           let fetchedBGitem = fetchBGitem(for: objectId, context: context) {
            bgItem = fetchedBGitem
        } else {
            bgItem = BGitem(context: context)
        }
        
        bgItem.name = bgItemValues.name
        bgItem.type = bgItemValues.type
        bgItem.action = bgItemValues.action
        bgItem.reward = bgItemValues.reward
        bgItem.area = bgItemValues.area
        bgItem.location = bgItemValues.location
        bgItem.subArea = bgItemValues.subArea
        bgItem.isDone = bgItemValues.isDone
        
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
}
