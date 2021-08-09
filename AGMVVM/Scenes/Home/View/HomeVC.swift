//
//  HomeVC.swift
//  AGMVVM
//
//  Created by ahmed gado on 03/08/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import UIKit

class HomeVC: MainViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel : HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(delegate: self)

        setupTableView()
        setupViewModel()
        // Do any additional setup after loading the view.
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCellNib(cellClass: HomeTableCell.self)
    }
    func setupViewModel(){
        viewModel.reloadData = { [weak self]  in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

  
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getHomeDetailsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HomeTableCell
        viewModel.configerCell(cell: cell, index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(index: indexPath.row)
    }
    
}
