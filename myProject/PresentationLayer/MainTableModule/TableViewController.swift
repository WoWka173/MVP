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
        tableView.allowsSelection = false
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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        setupNavigationBar()
        presenter.view = self
        presenter.viewDidLoad()
        setupSearchBar()
        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        reloadTableView()
        
    }
    
    // MARK: - Methods
    private func setupSearchBar() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.isActive = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Wild Life"
    }
}

//MARK - MainTableViewProtocol
extension TableViewController: TableViewProtocol {
    
    func setupTableView() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
    }

    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
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

extension TableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.presenter.searchResult(searchText: searchText)
            
        }
    }
}



