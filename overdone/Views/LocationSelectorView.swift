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
    
    @ObservedObject var location: LocationObservable
    private var mapSearcher: MapViewModel
    
    init() {
        let loc = LocationObservable()
        location = loc
        mapSearcher = MapViewModel(location: loc)
    }
    
    private let locationManager = CLLocationManager()
    private var currentPlacemark: CLPlacemark?
    
    var body: some View {
        VStack {
            HStack {
                TextField("1 Infinite Loop California", text: $location.query)
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
                            Text(entry.title + " " + entry.subtitle)
                    }
                }
            }
        }
    }
}


struct LocationSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectorView()
    }
}
