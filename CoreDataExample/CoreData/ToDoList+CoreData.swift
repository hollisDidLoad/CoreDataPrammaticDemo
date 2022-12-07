//
//  ToDoList+CoreData.swift
//  CoreDataExample
//
//  Created by Hollis Kwan on 11/4/22.
//

import CoreData

class ToDoList: NSManagedObject {
       
    class func fetchToDoListItems() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }
    
    @NSManaged public var item: String
}
