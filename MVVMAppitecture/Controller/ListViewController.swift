//
//  ListViewController.swift
//  MVVMAppitecture
//
//  Created by Rupin on 1/15/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var viewModels: [ViewModel] {
        return viewDataModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List of Nebula"
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.viewModel = viewModels[indexPath.row]
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "ShowDetail":
            guard let detailViewController = segue.destination as? DetailViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedCell = sender as? ListTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            detailViewController.viewModel = viewModels[indexPath.row]
            
        default:
            break
        }
    }
}
