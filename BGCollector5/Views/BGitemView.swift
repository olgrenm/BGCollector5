//
//  BGitemView.swift
//  BGCollector5
//
//  Created by Michael Olgren on 1/17/22.
//

import SwiftUI

struct BGitemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var bgItem: BGitem
    
    var body: some View {
        HStack {
            VStack {
                Text(bgItem.isDone ? Image(systemName: "checkmark.square") : Image(systemName: "square"))
                    .font(.title)
                Spacer()
                TypeView(type: bgItem.type)
                    .font(.title)
                    .padding(.bottom)
            }
            .frame(width: 60, height: 100)
            VStack(alignment: .leading) {
                Text("\(bgItem.name)")
                    .font(.headline)
                if !bgItem.isFault {
                    Text(bgItem.action)
                        .foregroundColor(.secondary)
                    HStack {
                        Text(bgItem.location)
                        Spacer()
                        Text(bgItem.subArea)
                            .padding(.trailing)
                    }
                    .foregroundColor(.secondary)
                    Text(bgItem.reward)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct BGitemView_Previews: PreviewProvider {
    static var previews: some View {
        BGitemView(bgItem: getBGitem())
    }
    
    static func getBGitem() -> BGitem {
        let bgItem = BGitem(context: PersistenceManager(inMemory: true).persistentContainer.viewContext)
    bgItem.name = "Viconia (NE clr (mace/sling)"
    bgItem.type = "companion"
    bgItem.action = "fight soldier"
    bgItem.reward = "240xp, plate, Rep -2"
    bgItem.area = "AR0000"
    bgItem.location = "NW"
    bgItem.subArea = "L1 townhouse"
    bgItem.isDone = true
    return bgItem
}
}
