//
//  TodoEntry+CoreDataProperties.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-11-16.
//
//

import Foundation
import CoreData


extension TodoEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoEntry> {
        return NSFetchRequest<TodoEntry>(entityName: "TodoEntry")
    }

    @NSManaged public var dueDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var location: String?
    @NSManaged public var repeating: Bool
    @NSManaged public var text: String?
    @NSManaged public var image: Data?

}

extension TodoEntry : Identifiable {

}
