//
//  DrilldownView.swift
//  Overdone
//
//  Created by Ari Dokmecian on 2020-09-26.
//

import SwiftUI
import CoreData

struct DrilldownView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.editMode) var editMode
    
    init(entry: TodoEntry) {
        _entry = .init(initialValue: entry)
        _text = .init(initialValue: entry.text ?? "")
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
    @State private var entry: TodoEntry
    
    var isEdited: Bool {
        self.editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View {
        VStack {
            if (isEdited) {
                EntryView(text: $text, repeating: $repeating, isDueDate: $isDueDate, dueDate: $dueDate, isLocation: $isLocation, location: $location)
                    .environment(\.managedObjectContext, viewContext)
            } else {
                DetailView(entry: $entry)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if (isEdited) {
                        updateEntry(entry: entry)
                        editMode?.wrappedValue = EditMode.inactive
                    } else {
                        editMode?.wrappedValue = EditMode.active
                    }
                }, label: {
                    Text( isEdited ? "Save" : "Edit")
                })
            }
        }
    }
                
    func updateEntry(entry: TodoEntry) {
        entry.text = text
        entry.repeating = repeating
        entry.dueDate = (isDueDate) ? dueDate : nil
        entry.location = (isLocation) ? location : nil
        entry.id = UUID()
        do {
            try withAnimation {
                try viewContext.save()
            }
        }
        catch {
            fatalError("resolve before shipping app")
        }
    }
}

struct DrilldownView_Previews: PreviewProvider {
    @State static var entry = TodoEntry()
    
    static var previews: some View {
        let store = PersistenceController.preview
        return DrilldownView(entry: TodoEntry(context: store.container.viewContext, text: "Name"))
    }
}
