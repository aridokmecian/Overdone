//
//  MapViewModel.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-11-23.
//

import Foundation
import SwiftUI
import MapKit
import Combine

class MapViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @ObservedObject private var location: LocationObservable
    
    var completer: MKLocalSearchCompleter
    var cancellable: AnyCancellable?
    
    init(location: LocationObservable) {
        completer = MKLocalSearchCompleter()
        self.location = location
        super.init()
        cancellable = location.$query.debounce(for: .milliseconds(100), scheduler: RunLoop.main).assign(to: \.queryFragment, on: self.completer)
        completer.delegate = self
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        location.results = completer.results
    }
}

extension MKLocalSearchCompletion: Identifiable {}
