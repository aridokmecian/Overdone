//
//  entryView.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-09-27.
//

import SwiftUI

struct EntryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var text: String
    @Binding var repeating: Bool
    @Binding var isDueDate: Bool
    @Binding var dueDate: Date
    @Binding var isLocation: Bool
    @Binding var location: String
    
    var body: some View {
        Form {
            Section(header: Text("Task")) {
                TextField("invert a binary tree ...", text: $text)
                    .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
            }
            Section(header: Text("Date")) {
                Toggle(isOn: $isDueDate) {
                    Text("Due date")
                }
                if (isDueDate) {
                    DatePicker("Date", selection: $dueDate)
                        .datePickerStyle(CompactDatePickerStyle())
                        .frame(height: 50)
                    Toggle(isOn: $repeating) {
                        Text("repeating event")
                    }
                }
                
            }
            
            Section(header: Text("Location")) {
                Toggle(isOn: $isLocation) {
                    Text("Location")
                }
                
                if (isLocation) {
                    TextField("1 Infinite Loop, California ...", text: $location)
                        .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
    
    func updateEntry() {
        let entry = TodoEntry(context: viewContext)
        entry.text = text
        entry.repeating = repeating
        entry.dueDate = (isDueDate) ? dueDate : nil
        entry.location = (isLocation) ? location : nil
        entry.id = UUID()
        
        do {
            try viewContext.save()
        }
        catch {
            fatalError("resolve before shipping app")
        }
    }
}

struct entryView_Previews: PreviewProvider {
    
    @State static var text = "hello world"
    @State static var repeating = false
    @State static var isDueDate = true
    @State static var dueDate = Date()
    @State static var isLocation = true
    @State static var location = "at home"

    
    static var previews: some View {
        EntryView(text: $text, repeating: $repeating, isDueDate: $isDueDate, dueDate: $dueDate, isLocation: $isLocation, location: $location)
    }
}
