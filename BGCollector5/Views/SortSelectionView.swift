//
//  SortSelectionView.swift
//  BGCollector5
//
//  Created by Michael Olgren on 2/18/22.
//

import SwiftUI

struct SortSelectionView: View {
    @Binding var selectedSortItem: BGitemSort
    
    let sorts: [BGitemSort]
    
    var body: some View {
        Menu {
            Picker("Sort by", selection: $selectedSortItem) {
                ForEach(sorts, id: \.self) { sort in
                    Text("\(sort.name)")
                }
            }
        } label: {
            Label(
            "Sort",
            systemImage: "line.horizontal.3.decrease.circle")
        }
        .pickerStyle(.inline)
    }
}

struct SortSelectionView_Previews: PreviewProvider {
    @State static var sort = BGitemSort.default
    static var previews: some View {
        SortSelectionView(
            selectedSortItem: $sort, sorts: BGitemSort.sorts)
    }
}
