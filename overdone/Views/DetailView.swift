//
//  DetailView.swift
//  Overdone
//
//  Created by Ari Dokmecian on 2020-09-27.
//

import SwiftUI

struct DetailView: View {

    @Binding var text: String
    @Binding var repeating: Bool
    @Binding var isDueDate: Bool
    @Binding var dueDate: Date
    @Binding var isLocation: Bool
    @Binding var location: String
    @Binding var image: UIImage?
    
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
                    Text(location)
                }
            }
            
            if (image != nil) {
                Section(header: Text("Image")) {
                    Image(uiImage: self.image!)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .shadow(radius: 10)
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
    @State static var image: UIImage? = nil
    
    static var previews: some View {
        DetailView(text: $text, repeating: $repeating, isDueDate: $isDueDate, dueDate: $dueDate, isLocation: $isLocation, location: $location, image: $image)
    }
}
