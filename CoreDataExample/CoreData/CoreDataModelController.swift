//
//  CoreDataModelController.swift
//  CoreDataExample
//
//  Created by Hollis Kwan on 11/4/22.
//

import Foundation

class CoreDataModelController {
    static let shared = CoreDataModelController()
    private init() {}
    
    let context = CoreDataStack.context
    var toDoList = [ToDoList]()
    
    func retrieveToDoItems(completion: @escaping () -> Void) {
        do {
            toDoList = try context.fetch(ToDoList.fetchToDoListItems())
            DispatchQueue.main.async {
                completion()
            }
        } catch {
            print("Error retrieving Core Data: \(error)")
        }
    }
    
    func createToDoListItem(with item: String) {
        let newToDoItem = ToDoList(context: context)
        newToDoItem.item = item
        saveItem()
    }
    
    func updateToDoListItem(with listItem: ToDoList, newItem: String) {
        listItem.item = newItem
        saveItem()
    }
    
    func deleteToDoListItem(with data: ToDoList) {
        context.delete(data)
        saveItem()
    }
    
    func saveItem() {
        do {
            try context.save()
        } catch {
            print("Error saving Core Data: \(error)")
        }
    }
}
