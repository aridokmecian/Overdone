//
//  ContentView.swift
//  Overdone
//
//  Created by Ari Dokmecian on 2020-09-23.
//

import SwiftUI
import CoreData

struct ContentView: View {
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
//                            .onDelete(perform: deleteEntry)
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
                .environment(\.managedObjectContext, self.viewContext)
        }
    }
    
    private func deleteEntry(offsets: IndexSet) {
        offsets.map { entries[$0] }.forEach(viewContext.delete)
        
        do {
            try withAnimation {
                try viewContext.save()
            }
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
