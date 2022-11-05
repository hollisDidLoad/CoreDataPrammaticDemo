//
//  ToDoListView.swift
//  CoreDataExample
//
//  Created by Hollis Kwan on 11/4/22.
//

import Foundation
import UIKit

class ToDoListView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func configureCell(with cell: UITableViewCell, and text: String) {
        cell.textLabel?.text = text
    }
    
    func presentUpdateItemAlert(
        with indexPath: IndexPath,
        _ toDoList: ToDoList,
        and textCompletion: @escaping (String) -> Void,
        completion: @escaping (UIAlertController) -> Void) {
            let alert = UIAlertController(
                title: "Update Item",
                message: nil,
                preferredStyle: .alert
            )
            alert.addTextField()
            alert.textFields?.first?.text = toDoList.item
            alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
                guard let field = alert.textFields?.first,
                      let text = field.text,
                      !text.isEmpty
                else { return }
                
                textCompletion(text)
            }))
            completion(alert)
        } 
    
    func presentNewItemAlert(_ textCompletion: @escaping (String) -> Void, completion: @escaping (UIAlertController) -> Void) {
        let alert = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else { return }
            textCompletion(text)
        }))
        completion(alert)
    }
}
