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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(entries) { entry in
                    NavigationLink(
                        destination: DrilldownView(entry: entry),
                        label: {
                            Text("\(entry.text!)")
                        })
                }
                .onDelete(perform: deleteEntry)
            }
            .listStyle(InsetGroupedListStyle())
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
            try viewContext.save()
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
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
