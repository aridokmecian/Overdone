//
//  DetailView.swift
//  Overdone
//
//  Created by Ari Dokmecian on 2020-09-27.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var entry: TodoEntry
    
    var body: some View {
        Form {
            // Task section
            Section(header: Text("Task")) {
                Text(entry.text!)
            }
            
            // Due date section
            if (entry.dueDate != nil) {
                Section(header: Text("Due date")) {
                    Text(verbatim: getDate(date: entry.dueDate!))
                }
            }
            
            // Location Section
            if (entry.location != nil){
                Section(header: Text("Location")) {
                    Text(entry.location!.description)
                }
            }
        }
        .navigationBarTitle("Details", displayMode: .inline)
    }
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
}

struct DisplayView_Previews: PreviewProvider {    
    static var previews: some View {
        let store = PersistenceController.preview
        DetailView(entry: .constant(TodoEntry(context: store.container.viewContext, text: "Hello World")))
    }
}
