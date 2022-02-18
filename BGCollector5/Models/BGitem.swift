//
//  BGitem.swift
//  BGCollector5
//  for remote
//  Created by Michael Olgren on 1/17/22.
//

import CoreData

@objc(BGitem)
public class BGitem: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<BGitem> {
        return NSFetchRequest<BGitem>(entityName: "BGitem")
    }
    
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var action: String
    @NSManaged public var reward: String
    @NSManaged public var area: String
    @NSManaged public var location: String
    @NSManaged public var subArea: String
    @NSManaged public var isDone: Bool
}

extension BGitem: Identifiable {}

extension BGitem {
    static func generateTestBGitems(in context: NSManagedObjectContext) throws {
        let names = [
        "longsword +1",
        "An Errand for Buller 1/3",
        "Viconia (NE clr, mace/sling)",
        "Shank (assassin)",
        "loot chest",
        "Travel to Nashkel"
        ]
        let types = [
        "quest",
        "battle",
        "buy",
        "companion"
        ]
        let isDones = [
        true,
        false
        ]
        for name in names {
            let bgItem = BGitem(context: context)
            bgItem.name = name
            bgItem.type = types.randomElement()!
            bgItem.action = "wild action"
            bgItem.reward = "wild reward"
            bgItem.area = "wild area"
            bgItem.location = "wild location"
            bgItem.subArea = "wild sub-area"
            bgItem.isDone = isDones.randomElement()!
        }
        
        try context.save()
    }
}
