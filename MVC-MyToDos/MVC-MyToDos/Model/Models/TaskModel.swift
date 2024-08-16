//
//  TaskModel.swift
//  MVC-MyToDos
//
//  Created by 이종선 on 8/16/24.
//

import Foundation
import CoreData

struct TaskModel {
    var id: String!
    var title: String!
    var icon: String!
    var done: Bool!
    var createdAt: Date!
}


extension TaskModel: EntityModelMapProtocol {
    
    typealias EntityType = Task
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let task: Task = .init(context: context)
        task.id = self.id
        task.title = self.title
        task.icon = self.icon
        task.done = self.done
        task.createdAt = self.createdAt
        return task
    }
    
    static func mapFromEntity(_ entity: Task) -> Self {
        return .init(id: entity.id,
                     title: entity.title,
                     icon: entity.icon,
                     done: entity.done,
                     createdAt: entity.createdAt)
    }
}
