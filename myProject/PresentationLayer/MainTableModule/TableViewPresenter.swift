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
    var filterData: [Result] { get set }
    func viewDidLoad()
    func numberOfRowInSection() -> Int
    func cellForRow(_ tableView: UITableView, cellForRow indexPath: IndexPath) -> UITableViewCell
    func searchResult(searchText: String)
}

//MARK: - Presenter
final class TableViewPresenter: TableViewPresenterProtocol {
    
    weak var view: TableViewProtocol?
    var filterData: [Result] = []
    private var service: NetworkManager?
    private var model: [Result] = []
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
            
        tableViewCell.model = TableViewCellModel(description: filterData[indexPath.row].description ?? "None description",
                                                 image: filterData[indexPath.row].urls?.regular ?? "")
        } else {
            
            tableViewCell.model = TableViewCellModel(description: model[indexPath.row].description ?? "None description",
                                                     image: model[indexPath.row].urls?.regular ?? "")
        }
       
        tableViewCell.updateContent()
        return tableViewCell
    }
    
    func searchResult(searchText: String) {
        self.filterData.removeAll()
        guard searchText.isEmpty || searchText != " " else {
            print("search is empty")
            return
        }
        
        for item in model {
            let text = searchText.lowercased()
            let isArrayCountainDescription = item.description?.lowercased().range(of: text)
            if isArrayCountainDescription != nil {
                print("Search complete")
                self.filterData.append(item)
            }
        }
        print(filterData)
        
        if searchText == "" {
            isSearching = false
            view?.reloadTableView()
        } else {
            isSearching = true
            view?.reloadTableView()
        }
    }
    
    private func fetchData() {
        service?.fetchData ({ [weak self] results in
            guard let self = self else { return }
            self.model = results
            self.view?.reloadTableView()
        })
    }
}

extension TableViewPresenter: TableViewCellProtocol {
    
    func didPressTableViewCellFavouritesTutton(isSelected: Bool, model: TableViewCellModel) {
        if isSelected == true {
            print("selected - TRUE")
            Database.shared.appendElements(likeModel: model)
            print (Database.shared.modelDB)
        } else {
            print("selected - FALSE")
        }
    }
}
