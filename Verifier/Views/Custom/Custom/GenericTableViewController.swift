//
//  GenericTableViewController.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 12/25/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation

import UIKit

class GenericTableViewController<T, Cell: UITableViewCell>: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var tableView: UITableView!
    
    
    var items: [T]
    var configure: (Cell, T) -> Void
    var selectHandler:  ((T) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(items: [T], configure: @escaping (Cell, T) -> Void) {
        self.items = items
        self.configure = configure
        
//        super.init(style: .plain)
        super.init(nibName: nil, bundle: nil)
        self.initViews()
        
    }
    
    
    func initViews() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // ---------------------------------------------------------------------------------------------
    public func setSelectHandler(selectHandler: @escaping (T) -> Void) -> GenericTableViewController {
        self.selectHandler = selectHandler
        return self
    }
    
    
    public func enableSort() -> GenericTableViewController {
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing  = true
//        tableView.dragInteractionEnabled = true // Enable intra-app drags for iPhone.
//        tableView.dragDelegate = self
//        tableView.dropDelegate = self
        return self
    }
    
    // ---------------------------------------------------------------------------------------------
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let item = items[indexPath.row]
        configure(cell, item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        self.selectHandler?(item)
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
        }
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
//            // delete item at indexPath
//        tableView.deleteRows(at: [indexPath], with: .fade)
//
//        }
//        return [delete]
//    }
    
}
