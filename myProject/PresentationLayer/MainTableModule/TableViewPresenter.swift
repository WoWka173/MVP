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
    var filterData: [Results] { get set }
    func viewDidLoad()
    func numberOfRowInSection() -> Int
    func cellForRow(_ tableView: UITableView, cellForRow indexPath: IndexPath) -> UITableViewCell
    func searchResult(searchText: String)
    
}

//MARK: - Presenter
final class TableViewPresenter: TableViewPresenterProtocol {
    
    weak var view: TableViewProtocol?
    var filterData: [Results] = []
    private var model: [Results] = []
    private var service: NetworkManager?
    private var isSearching = false
    
    //MARK: - Init
    init() {
        
        self.service = NetworkManager()
    }
    
    //MARK: - Methods
    func viewDidLoad() {
        
        fetchData()
        view?.setupTableView()
       
    }
    
    func numberOfRowInSection() -> Int {
        
        if isSearching { return filterData.count }
        else { return model.count }
    }
    
    func cellForRow(_ tableView: UITableView, cellForRow indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        guard let tableViewCell = cell else { return  UITableViewCell() }
        tableViewCell.delegate = self
        
        if isSearching {
            
            tableViewCell.model = TableViewCellModel(id: filterData[indexPath.row].id ?? "",
                                                     description: filterData[indexPath.row].description ?? "None description",
                                                     image: filterData[indexPath.row].urls?.regular ?? "")
        } else {
            
            tableViewCell.model = TableViewCellModel(id: model[indexPath.row].id ?? "",
                                                     description: model[indexPath.row].description ?? "None description",
                                                     image: model[indexPath.row].urls?.regular ?? "")
        }
        
        if let model = SQLCommands.presentRows() {
            
            model.forEach {
                
                if tableViewCell.model?.id == $0.id {
                    tableViewCell.isSelectedButton = true
                    tableViewCell.likeButton.tintColor = .red
                    
                }
            }
        }
        
        tableViewCell.updateContent()
        return tableViewCell
    }
    
    func searchResult(searchText: String) {
        
        self.filterData.removeAll()
        guard searchText.isEmpty || searchText != " " else { return }
        
        model.forEach {
            
            let text = searchText.lowercased()
            let isArrayCountainDescription = $0.description?.lowercased().range(of: text)
            if isArrayCountainDescription != nil {
                self.filterData.append($0)
                
            }
        }
        
        if searchText == "" {
            
            isSearching = false
            view?.reloadTableView()
            
        } else {
            
            isSearching = true
            view?.reloadTableView()
            
        }
    }
    
    private func fetchData() {
        
        service?.fetchData { [weak self] result in
            guard let self = self else { return }
            self.model = result
            self.view?.reloadTableView()
            
        }
    }
}

//MARK: - Extensions
extension TableViewPresenter: TableViewCellProtocol {
    
    func didPressTableViewCellLikeButton(isSelected: Bool, model: TableViewCellModel) {
        if isSelected {
            let database = SQLCommands.presentRows()
            guard let  database = database else { return }
            database.forEach {
                if model.id == $0.id { return }
                
            }
        
            let data = Data(model.image.utf8)
            SQLCommands.insertRow(DatabaseModel(id: model.id,
                                                description: model.description,
                                                image:data ))
            
        } else {
            SQLCommands.deleteRow(dataId: model.id)
        }
    }
}
