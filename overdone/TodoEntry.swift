//
//  TodoEntry.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-09-27.
//

import Foundation
import CoreData

extension TodoEntry {
    convenience init(context: NSManagedObjectContext, text: String, date: Date, repeating: Bool, location: String) {
        self.init(context: context)
        self.text = text
        self.dueDate = date
        self.repeating = repeating
        self.location = location
    }
}
