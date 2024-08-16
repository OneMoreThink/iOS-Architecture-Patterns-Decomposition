//
//  EntityModelMapProtocol.swift
//  MVC-MyToDos
//
//  Created by 이종선 on 8/16/24.
//

import Foundation
import CoreData

protocol EntityModelMapProtocol {

    associatedtype EntityType: NSManagedObject
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType
    static func mapFromEntity(_ entity: EntityType) -> Self
}
