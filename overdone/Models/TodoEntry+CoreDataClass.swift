//
//  TodoEntry+CoreDataClass.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-11-16.
//
//

import Foundation
import CoreData

@objc(TodoEntry)
public class TodoEntry: NSManagedObject {
    convenience init(context: NSManagedObjectContext, text: String, date: Date, repeating: Bool, location: String) {
        self.init(context: context)
        self.text = text
        self.dueDate = date
        self.repeating = repeating
        self.location = location
    }
}
