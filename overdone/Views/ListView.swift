//
//  ListView.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-11-20.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntry.dueDate, ascending: false)],
        animation: .default)
    
    private var entries: FetchedResults<TodoEntry>
    
    @State private var showSheet = false
    
    @State private var showButton = true
    
    @State private var selection = 0
    var body: some View {
        NavigationView {
            Group {
                if (entries.isEmpty) {
                    VStack(spacing: 16) {
                        Image("box")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Text("You have no tasks today! Take it easy!")
                        Button(action: {
                            self.showSheet = true
                        }, label: {
                            Text("Add a task!")
                        })
                    }
                } else {
                    ScrollView {
                        Picker("Priority", selection: $selection) {
                            Text("None").tag(0)
                                .font(.title)
                            Text("Low").tag(1)
                                .font(.title)
                            Text("High").tag(2)
                                .font(.title)
                        }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                        LazyVStack(alignment: .center, pinnedViews: [.sectionFooters]) {
                            Section(footer: FloatingButtonView(action: {self.showSheet = true}).padding()) {
                                
                                ForEach(entries) { entry in
                                    ListEntry(entry: entry)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showSheet = true
                    }) {
                        Label("Add Item", systemImage: "gearshape.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showSheet = true
                    }) {
                        Label("Add Item", systemImage: "plus.circle.fill")
                    }
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            NewTodoPage()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
