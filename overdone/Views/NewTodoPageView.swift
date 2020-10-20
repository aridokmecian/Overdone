//
//  newTodoPage.swift
//  Overdone
//
//  Created by Ari Dokmecian on 2020-09-24.
//
import SwiftUI
import CoreData

struct NewTodoPage: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var text = ""
    @State private var repeating = false
    @State private var isDueDate = false
    @State private var dueDate = Date()
    @State private var isLocation = false
    @State private var location = ""
    
    var body: some View {
        NavigationView {
            EntryView(text: $text, repeating: $repeating, isDueDate: $isDueDate, dueDate: $dueDate, isLocation: $isLocation, location: $location)
                .environment(\.managedObjectContext, viewContext)
                .navigationBarTitle(Text("New Todo"), displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {addEntry()}, label: {
                            Text("Save").font(.title).bold()
                        })
                    }
                }
        }
    }
    
    
    private func addEntry() {
        let entry = TodoEntry(context: viewContext)
        entry.text = text
        entry.repeating = repeating
        entry.dueDate = (isDueDate) ? dueDate : nil
        entry.location = (isLocation) ? location : nil
        entry.id = UUID()
        
        do {
            try viewContext.save()
            self.presentationMode.wrappedValue.dismiss()
        }
        catch {
            fatalError("resolve before shipping app")
        }
    }
    
}

struct newTodoPage_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoPage()
    }
}
