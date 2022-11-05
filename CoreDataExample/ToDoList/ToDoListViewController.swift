//
//  ToDoListViewController.swift
//  CoreDataExample
//
//  Created by Hollis Kwan on 11/4/22.
//

import Foundation
import UIKit

class ToDoListViewController: UIViewController {
    
    let contentView = ToDoListView()
    let viewModel = ToDoListViewModel(
        coreDataController: CoreDataModelController.shared
    )
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    private func setUpNavBar() {
        navigationItem.title = "To Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
    }
    
    @objc
    private func addButtonTapped() {
        contentView.presentNewItemAlert({ [weak self] text in
            self?.viewModel.createToDoListItem(with: text)
            self?.reloadData()
        }, completion: { [weak self] alert in
            self?.present(alert, animated: true)
        })
    }
    
    private func reloadData() {
        viewModel.reloadData { [weak self] in
            self?.contentView.tableView.reloadData()
        }
    }
}

//MARK: - TableView Delegate and Datasource

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coreDataController.toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let toDoItem = viewModel.coreDataController.toDoList[indexPath.row].item
        contentView.configureCell(with: cell, and: toDoItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contentView.tableView.deselectRow(at: indexPath, animated: true)
        let toDoItem = viewModel.coreDataController.toDoList[indexPath.row]
        contentView.presentUpdateItemAlert(with: indexPath, toDoItem, and: { [weak self] name in
            self?.viewModel.updateTodoListItem(with: toDoItem, newItem: name)
            self?.reloadData()
        }, completion: { [weak self] alert in
            self?.present(alert, animated: true)
        })
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDoItem = viewModel.coreDataController.toDoList[indexPath.row]
            viewModel.deleteToDoListItem(with: toDoItem)
            reloadData()
        }
    }
}
