//
//  NSManagedObject+Extensions.swift
//  MVC-MyToDos
//
//  Created by 이종선 on 8/16/24.
//

import Foundation
import CoreData

public extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }

}
