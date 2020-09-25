//
//  newTodoPage.swift
//  twodo
//
//  Created by Ari Dokmecian on 2020-09-24.
//

import SwiftUI

struct newTodoPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: addEntry) {
                    Text("Add new entry")
                }
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                        Text("Done").font(.title).bold()
                    })
                }
            }
        }
    }
    
    
    private func addEntry() {
        let entry = TodoEntry(context: viewContext)
        entry.text = "hello"
        entry.repeating = false
        entry.dueDate = Date()
        entry.location = "home"
        
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
        newTodoPage()
    }
}
