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
    
    @State private var text = ""
    @State private var repeating = false
    @State private var isDueDate = false
    @State private var dueDate = Date()
    @State private var isLocation = false
    @State private var location = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What do you want todo")) {
                    TextField("eat a pizza ...", text: $text)
                        .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                }
                
                if (text != "") {
                    
                    Section(header: Text("Do you want to set a due date?")) {
                        Toggle(isOn: $isDueDate) {
                            Text("Due date")
                        }
                        if (isDueDate) {
                            DatePicker("Date", selection: $dueDate)
                                .datePickerStyle(CompactDatePickerStyle())
                                .frame(height: 50)
                            Toggle(isOn: $repeating) {
                                Text("repating event?")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Do you want to set a location?")) {
                        Toggle(isOn: $isLocation) {
                            Text("Location")
                        }
                        if (isLocation) {
                            TextField("1 infinite loop, california ...", text: $location)
                                .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {addEntry()}, label: {
                        Text("Done").font(.title).bold()
                    })
                }
            }
        }
    }
    
    
    private func addEntry() {
        let entry = TodoEntry(context: viewContext)
        entry.text = text
        entry.repeating = repeating
        entry.dueDate = dueDate
        entry.location = location
        
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
