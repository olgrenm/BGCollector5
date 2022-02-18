//
//  ContentView.swift
//  BGCollector5
//
//  Created by Michael Olgren on 1/17/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var addViewShown = false
    let viewModel = ListViewModel()
    
    @SectionedFetchRequest(
        sectionIdentifier: BGitemSort.default.section,
        sortDescriptors: BGitemSort.default.descriptors,
        animation: .default)
    private var bgItems: SectionedFetchResults<String, BGitem>
    
    @State private var selectedSort = BGitemSort.default
    @State private var searchTerm = ""
    var searchQuery: Binding<String> {
        Binding {
            searchTerm
        } set: { newValue in
            searchTerm = newValue
            
            guard !newValue.isEmpty else {
                bgItems.nsPredicate = nil
                return
            }
            
            bgItems.nsPredicate = NSPredicate(
                format: "name contains[cd] %@",
            newValue)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bgItems) { section in
                    Section(header: Text(section.id)) {
                        ForEach(section) { bgItem in
                            NavigationLink {
                                AddBGitemView(bgItemId: bgItem.objectID)
                            } label: {
                                BGitemView(bgItem: bgItem)
                            }
                        }
                        .onDelete { indexSet in
                            withAnimation {
                                viewModel.deleteItem(
                                    for: indexSet,
                                       section: section,
                                       viewContext: viewContext)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $addViewShown) {
                AddBGitemView()
            }
            .navigationTitle("BG Items")
            .searchable(text: searchQuery)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    SortSelectionView(
                        selectedSortItem: $selectedSort,
                        sorts: BGitemSort.sorts)
                    
                        .onChange(of: selectedSort) { _ in
                            let request = bgItems
                            request.sectionIdentifier = selectedSort.section
                            request.sortDescriptors = selectedSort.descriptors
                        }
                    Button {
                        addViewShown = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
