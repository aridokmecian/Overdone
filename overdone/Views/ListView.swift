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
                        LazyVStack(alignment: .center, pinnedViews: [.sectionFooters]) {
                            Section(footer: FloatingButtonView(action: {self.showSheet = true})) {
                                
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
                        Label("Add Item", systemImage: "plus")
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
