//
//  newTodoPage.swift
//  twodo
//
//  Created by Ari Dokmecian on 2020-09-24.
//

import SwiftUI

struct newTodoPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showSheet: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {addEntry()}, label: {
                    Text("Add new entry")
                })
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {self.showSheet.toggle()}, label: {
                        Text("Done").bold()
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
        }
        catch {
            fatalError("resolve before shipping app")
        }
    }
    
}

struct newTodoPage_Previews: PreviewProvider {
    static var previews: some View {
        newTodoPage(showSheet: .constant(true))
    }
}
