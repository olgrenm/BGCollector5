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
    
    static let sorts: [BGitemSort] = [
    BGitemSort(
        id: 0,
        name: "Name | Ascending",
        descriptors: [
            SortDescriptor(\BGitem.name, order: .forward),
            SortDescriptor(\BGitem.isDone, order: .forward)
        ]),
    BGitemSort(
        id: 1,
        name: "Name | Descending",
        descriptors: [
            SortDescriptor(\BGitem.name, order: .reverse),
            SortDescriptor(\BGitem.isDone, order: .forward)
        ]),
    BGitemSort(
        id: 2,
        name: "Type | Ascending",
        descriptors: [
            SortDescriptor(\BGitem.type, order: .forward),
            SortDescriptor(\BGitem.name, order: .forward)
        ]),
    BGitemSort(
        id: 3,
        name: "Type | Descending",
        descriptors: [
            SortDescriptor(\BGitem.type, order: .reverse),
            SortDescriptor(\BGitem.name, order: .forward)
        ])
    ]
    
    static var `default`: BGitemSort { sorts[0] }
}
