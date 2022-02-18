//
//  BGitemSort.swift
//  BGCollector5
//
//  Created by Michael Olgren on 2/18/22.
//

import Foundation

struct BGitemSort: Hashable, Identifiable {
    let id: Int
    let name: String
    let descriptors: [SortDescriptor<BGitem>]
    let section: KeyPath<BGitem, String>
    
    static let sorts: [BGitemSort] = [
        BGitemSort(
            id: 0,
            name: "Area | Ascending",
            descriptors: [
                SortDescriptor(\BGitem.area, order: .forward),
                SortDescriptor(\BGitem.isDone, order: .forward),
                SortDescriptor(\BGitem.name, order: .forward)
            ],
            section: \BGitem.area),
        BGitemSort(
            id: 1,
            name: "Area | Descending",
            descriptors: [
                SortDescriptor(\BGitem.area, order: .reverse),
                SortDescriptor(\BGitem.isDone, order: .forward),
                SortDescriptor(\BGitem.name, order: .forward)
            ],
            section: \BGitem.area),
        BGitemSort(
            id: 2,
            name: "Type | Ascending",
            descriptors: [
                SortDescriptor(\BGitem.type, order: .forward),
                SortDescriptor(\BGitem.isDone, order: .forward)
            ],
            section: \BGitem.type),
        BGitemSort(
            id: 3,
            name: "Type | Descending",
            descriptors: [
                SortDescriptor(\BGitem.type, order: .reverse),
                SortDescriptor(\BGitem.isDone, order: .forward)
            ],
            section: \BGitem.type)
    ]
    
    static var `default`: BGitemSort { sorts[0] }
}
