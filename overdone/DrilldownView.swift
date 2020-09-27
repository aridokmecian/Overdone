//
//  DrilldownView.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-09-26.
//

import SwiftUI
import CoreData

struct DrilldownView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.editMode) var editMode
    
    
    // Super Useful later
    //    let req = FetchRequest<TodoEntry>(
    //        entity: TodoEntry.entity(),
    //        sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntry.dueDate, ascending: true)],
    //        predicate: NSPredicate(format: "id == %@", entryID), animation: .default)
    //
    //    let entryRequest: FetchRequest<TodoEntry>
    //    var entry: FetchedResults<TodoEntry> { entryRequest.wrappedValue }
    
    init(entry: TodoEntry) {
        _text = .init(initialValue: entry.text!)
        _repeating = .init(initialValue: entry.repeating)
        _isDueDate = .init(initialValue: entry.dueDate != nil)
        _dueDate = .init(initialValue: entry.dueDate ?? Date())
        _isLocation = .init(initialValue: entry.location != nil)
        _location = .init(initialValue: entry.location ?? "")
    }
    
    @State private var text: String
    @State private var repeating: Bool
    @State private var isDueDate: Bool
    @State private var dueDate: Date
    @State private var isLocation: Bool
    @State private var location: String
    
    var body: some View {
        Form() {
            
            let isEdited = { self.editMode!.wrappedValue.isEditing }
            
            // Task section
            Section(header: Text("Task")) {
                if (isEdited()) {
                    TextField(text, text: $text)
                } else {
                    Text(text)
                }
            }
            
            
            // Due date section
            if (isEdited()) {
                Section(header: Text("Date")) {
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
            } else {
                if (isDueDate) {
                    Section(header: Text("Due date")) {
                        Text(verbatim: getDate(date: dueDate))
                    }
                }
            }
            
            
            // Location Section
            if (isLocation){
                if (isEdited()) {
                    Section(header: Text("Location")) {
                        Toggle(isOn: $isLocation) {
                            Text("Location")
                        }
                        
                        if (isLocation) {
                            TextField("1 infinite loop, california ...", text: $location)
                                .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                        }
                    }
                } else {
                    Section(header: Text("Location")) {
                        Text(location.description)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Details"), displayMode: .inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                
            }
        })
        
    }
    
    
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
}

struct DrilldownView_Previews: PreviewProvider {
    static var previews: some View {
        
        let store = PersistenceController.preview
        
        NavigationView {
            DrilldownView(entry: TodoEntry(context: store.container.viewContext ,text: "hello World", date: Date(), repeating: false, location: "my house"))
        }
        
    }
    
    
}
