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
    
    @FetchRequest(
        sortDescriptors: [
        NSSortDescriptor(
            keyPath: \BGitem.area,
            ascending: true)
        ],
        animation: .default)
    private var bgItems: FetchedResults<BGitem>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bgItems) { bgItem in
                    NavigationLink {
                        AddBGitemView(bgItemId: bgItem.objectID)
                    } label: {
                        BGitemView(bgItem: bgItem)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteItem(
                        for: indexSet,
                        section: bgItems,
                        viewContext: viewContext)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addViewShown = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $addViewShown) {
                AddBGitemView()
            }
            .navigationTitle("BG Items")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}