//
//  LocationObservable.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-11-22.
//

import SwiftUI
import Foundation
import MapKit

class LocationObservable: ObservableObject {
    @Published var query = ""
    @Published var results = [MKLocalSearchCompletion]()
}
