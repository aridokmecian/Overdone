//
//  LocationSelectorView.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-11-22.
//

import SwiftUI
import CoreLocation
import MapKit

struct LocationSelectorView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var location = LocationObservable()
    @Binding var result: String
    @State private var mapSearcher: MapViewModel?
    
    private let locationManager = CLLocationManager()
     var currentPlacemark: CLPlacemark?
    
    var body: some View {
        VStack {
            HStack {
                TextField("1 Infinite Loop Cupertino, CA, United States", text: $location.query)
                    .padding()
                Button(action: {
                    location.query = ""
                }) {
                    Text("clear")
                }
            }
            .padding()
            List {
                if (!location.results.isEmpty) {
                    ForEach(location.results) { entry in
                        Button(action: {
                            result = entry.title + " " + entry.subtitle
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text(entry.title + " " + entry.subtitle)
                        }
                    }
                }
            }
        }
        .onAppear {
            self.mapSearcher = MapViewModel(location: location)
            
        }
    }
}


struct LocationSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectorView(result: .constant("Hello World"))
    }
}
