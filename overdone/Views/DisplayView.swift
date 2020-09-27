//
//  DisplayView.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-09-27.
//

import SwiftUI

struct DisplayView: View {
    
    
    @Binding var text: String
    @Binding var repeating: Bool
    @Binding var isDueDate: Bool
    @Binding var dueDate: Date
    @Binding var isLocation: Bool
    @Binding var location: String
    
    var body: some View {
        Form {
            // Task section
            Section(header: Text("Task")) {
                Text(text)
            }
            
            // Due date section
            if (isDueDate) {
                    Section(header: Text("Due date")) {
                        Text(verbatim: getDate(date: dueDate))
                }
            }
            
            
            // Location Section
            if (isLocation){
                Section(header: Text("Location")) {
                    Text(location.description)
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
    @State static var text = "hello world"
    @State static var repeating = false
    @State static var isDueDate = true
    @State static var dueDate = Date()
    @State static var isLocation = true
    @State static var location = "at home"

    
    static var previews: some View {
        DisplayView(text: $text, repeating: $repeating, isDueDate: $isDueDate, dueDate: $dueDate, isLocation: $isLocation, location: $location)
    }
}
