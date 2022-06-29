//
//  ViewController.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import UIKit
import SnapKit

final class TableViewController: UIViewController {
    
    //MARK: - Properties
    private var presenter: TableViewPresenterProtocol
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        return tableView
    }()
    
    //MARK: - Init
    init(presenter: TableViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    // MARK: - Methods
        private func setupNavigationBar() {
            navigationItem.title = "Gallery"
    }
}

//MARK - MainTableViewProtocol
extension TableViewController: TableViewProtocol {
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func reloadTableView() {
        tableView.reloadData()
    }
}

//MARK: - Extension
extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.cellForRow(tableView, cellForRow: indexPath)
    }
}


