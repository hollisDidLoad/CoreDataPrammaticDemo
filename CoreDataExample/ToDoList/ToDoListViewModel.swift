//
//  ToDoListViewModel.swift
//  CoreDataExample
//
//  Created by Hollis Kwan on 11/4/22.
//

import Foundation

class ToDoListViewModel {
    
    let coreDataController: CoreDataModelController
    
    init(coreDataController: CoreDataModelController) {
        self.coreDataController = coreDataController
    }
    
    func reloadData(completion: @escaping () -> Void) {
        coreDataController.retrieveToDoItems {
            completion()
        }
    }
    
    func createToDoListItem(with text: String) {
        self.coreDataController.createToDoListItem(with: text)
    }
    
    func updateTodoListItem(with toDoItem: ToDoList, newItem: String) {
        self.coreDataController.updateToDoListItem(with: toDoItem, newItem: newItem)
    }
    
    func deleteToDoListItem(with toDoItem: ToDoList) {
        self.coreDataController.deleteToDoListItem(with: toDoItem)
    }
}
