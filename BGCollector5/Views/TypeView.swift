//
//  TypeView.swift
//  BGCollector5
//
//  Created by Michael Olgren on 1/17/22.
//

import SwiftUI

struct TypeView: View {
    let type: String
    
    var body: some View {
        switch type {
        case "companion":
            return Image(systemName: "person.fill")
        case "buy":
            return Image(systemName: "cart.fill")
        case "battle":
            return Image(systemName: "bolt")
        case "find":
            return Image(systemName: "star.fill")
        case "main":
            return Image(systemName: "crown.fill")
        case "quest":
            return Image(systemName: "crown")
        default:
            return Image(systemName: "questionmark.circle")
        }
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView(type: "quest")
    }
}
