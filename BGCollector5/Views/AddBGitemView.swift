//
//  AddBGitemView.swift
//  BGCollector5
//
//  Created by Michael Olgren on 1/17/22.
//

import SwiftUI
import CoreData

struct AddBGitemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    @State private var name = ""
    @State private var nameError = false
    @State private var type = "quest"
    @State private var action = ""
    @State private var reward = ""
    @State private var area = ""
    @State private var areaError = false
    @State private var location = ""
    @State private var subArea = ""
    @State private var isDone = false
    
    var bgItemId: NSManagedObjectID?
    let viewModel = AddBGitemViewModel()
    var types = ["buy", "battle", "companion", "find", "main", "quest"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    VStack {
                        TextField("Name", text: $name, prompt: Text("Name"))
                            .disableAutocorrection(true)
                            .font(.title)
                        if nameError {
                            Text("Name is required")
                                .foregroundColor(.red)
                        }
                    }
                    VStack {
                        Picker("Type", selection: $type) {
                            ForEach(types, id:\.self) {
                                Text($0)
                            }
                        } .pickerStyle(WheelPickerStyle())
                    }
                    VStack {
                        TextField("Area", text: $area, prompt: Text("Area"))
                            .disableAutocorrection(true)
                        if areaError {
                            Text("Area is required")
                                .foregroundColor(.red)
                        }
                    }
                    VStack {
                        TextField("Action", text: $action, prompt: Text("Action"))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .border(.secondary)
                        TextField("Location", text: $location, prompt: Text("Location"))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .border(.secondary)
                        TextField("Sub-area", text: $subArea, prompt: Text("Sub-area"))
                            .disableAutocorrection(true)
                            .padding()
                            .border(.secondary)
                        TextField("Reward", text: $reward, prompt: Text("Reward"))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .border(.secondary)
                        Toggle("Done with item?", isOn: $isDone)
                            .padding(.top)
                    }
                }
                
                Button {
                    if name.isEmpty || area.isEmpty {
                        nameError = name.isEmpty
                        areaError = area.isEmpty
                    } else {
                        let values = BGitemValues(
                            name: name,
                            type: type,
                            action: action,
                            reward: reward,
                            area: area,
                            location: location,
                            subArea: subArea,
                            isDone: isDone)
                        
                        viewModel.saveBGitem(
                            bgItemId: bgItemId,
                            with: values,
                            in: viewContext)
                        presentation.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: 300)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .controlSize(.large)
            }
            .navigationTitle("\(bgItemId == nil ? "Add Item" : "Edit Item")")
            Spacer()
        }
        .onAppear {
            guard
                let objectId = bgItemId,
                let bgItem = viewModel.fetchBGitem(for: objectId, context: viewContext)
            else {
                return
            }
            
            name = bgItem.name
            type = bgItem.type
            action = bgItem.action
            reward = bgItem.reward
            area = bgItem.area
            location = bgItem.location
            subArea = bgItem.subArea
            isDone = bgItem.isDone
        }
    }
}

struct AddBGitemView_Previews: PreviewProvider {
    static var previews: some View {
        AddBGitemView()
    }
}
