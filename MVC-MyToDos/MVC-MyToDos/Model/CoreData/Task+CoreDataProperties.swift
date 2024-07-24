//
//  Task+CoreDataProperties.swift
//  MVC-MyToDos
//
//  Created by 이종선 on 7/24/24.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var icon: String?
    @NSManaged public var done: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var list: TasksList?

}

extension Task : Identifiable {

}
