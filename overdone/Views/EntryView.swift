//
//  entryView.swift
//  Overdone
//
//  Created by Ari Dokmecian on 2020-09-27.
//

import SwiftUI
import MapKit

struct EntryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var text: String
    @Binding var repeating: Bool
    @Binding var isDueDate: Bool
    @Binding var dueDate: Date
    @Binding var isLocation: Bool
    @Binding var location: String
    
    @State private var loc: MKLocalSearchCompletion?
    
    var body: some View {
        Form {
            Section(header: Text("Task")) {
                TextField("invert a binary tree ...", text: $text)
                    .keyboardType(.default)
            }
            Section(header: Text("Date")) {
                Toggle(isOn: $isDueDate.animation()) {
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
                Toggle(isOn: $isLocation.animation()) {
                    Text("Location")
                }
                
                if (isLocation) {
                    NavigationLink(
                        destination: LocationSelectorView(result: $location),
                        label: {
                            Text(location.isEmpty ? "Click to add location" : location)
                        })
                }
            }
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
