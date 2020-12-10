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

    
    @Binding var entry: TodoEntry

    @State private var text: String = ""
    @State private var repeating: Bool = false
    @State private var isDueDate: Bool = false
    @State private var dueDate: Date = Date()
    @State private var isLocation: Bool = false
    @State private var location: String = ""
    
    @State private var showEditSheet = false
    
    var body: some View {
        Group {
            DetailView(text: $text, repeating: $repeating, isDueDate: $isDueDate, dueDate: $dueDate, isLocation: $isLocation, location: $location)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
               Button(action: {
                    self.showEditSheet = true
                }) {
                    Text("Edit")
                }
                .padding()
                .font(.title)
                .sheet(isPresented: $showEditSheet) {
                    NavigationView {
                        EntryView(text: $text, repeating: $repeating, isDueDate: $isDueDate, dueDate: $dueDate, isLocation: $isLocation, location: $location)
                            .environment(\.managedObjectContext, viewContext)
                            .navigationBarTitle(Text("Update Todo"), displayMode: .inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        updateEntry()
                                        self.showEditSheet.toggle()
                                    }, label: {
                                        Text("Save").font(.title).bold()
                                    })
                                }
                            }
                    }
                    
                }
            }
        }
        .onAppear {
            text = entry.text ?? ""
            repeating = entry.repeating
            isDueDate = entry.dueDate != nil
            dueDate = entry.dueDate ?? Date()
            isLocation = entry.location != nil
            location = entry.location ?? ""
            
        }
    }
    
                
    func updateEntry() {
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
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
}

struct DrilldownView_Previews: PreviewProvider {
    @State static var entry = TodoEntry()
    
    static var previews: some View {
        let store = PersistenceController.preview
        return DrilldownView(entry: .constant(TodoEntry(context: store.container.viewContext, text: "Hello World")))
    }
}
