//
//  TasksList+CoreDataProperties.swift
//  MVVM_MyToDos
//
//  Created by 이종선 on 1/3/25.
//
//

import Foundation
import CoreData


extension TasksList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TasksList> {
        return NSFetchRequest<TasksList>(entityName: "TasksList")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension TasksList {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension TasksList : Identifiable {

}
