//
//  Tasks+CoreDataProperties.swift
//  UIKitApp
//
//  Created by Vinícius Pinheiro on 16/06/20.
//  Copyright © 2020 Lucas Carvalho. All rights reserved.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var task: String?

}
