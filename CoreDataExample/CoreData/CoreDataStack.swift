//
//  CoreDataStack.swift
//  CoreDataExample
//
//  Created by Hollis Kwan on 11/4/22.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            guard let error = error as? NSError else { return }
            fatalError("\(error)")
        }
        return container
    }()
    
    static let context = container.viewContext
}
