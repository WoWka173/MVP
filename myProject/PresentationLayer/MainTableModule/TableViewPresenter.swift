//
//  TableViewPresenter.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import Foundation
import UIKit

//MARK: - Protocols
protocol TableViewProtocol: AnyObject {
    func setupTableView()
    func reloadTableView()
}

protocol TableViewPresenterProtocol: AnyObject {
    var view: TableViewProtocol? { get set }
    func viewDidLoad()
    func numberOfRowInSection() -> Int
    func cellForRow(_ tableView: UITableView, cellForRow indexPath: IndexPath) -> UITableViewCell
}

//MARK: - Presenter
final class TableViewPresenter: TableViewPresenterProtocol {
    
    weak var view: TableViewProtocol?
    private var service: UserNetwork?
    private var model: [Users] = []
    
    //MARK: - Init
    init() {
        self.service = UserNetwork()
    }
    
    //MARK: - Methods
    func viewDidLoad() {
        fetchData()
        view?.setupTableView()
    }
    
    func numberOfRowInSection() -> Int {
        return model.count
    }
    
    func cellForRow(_ tableView: UITableView, cellForRow indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        guard let tableViewCell = cell else { return  UITableViewCell() }
        tableViewCell.model = TableViewCellModel(name: model[indexPath.row].name, description: model[indexPath.row].description, image: model[indexPath.row].imageUser)
        tableViewCell.updateContent()
        return tableViewCell
                
    }
    
    private func fetchData() {
        service?.fetchUsersData { [weak self] usersdata in
            self?.model = usersdata
        }
    }
}



