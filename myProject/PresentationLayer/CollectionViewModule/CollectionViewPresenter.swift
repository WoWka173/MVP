//
//  CollectionViewPresenter.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import Foundation
import UIKit

//MARK: - Protocols
protocol CollectionViewProtocol: AnyObject {
    
    func setupCollectionView()
    func reloadCollectionView()
    
}

protocol CollectionPresenterProtocol: AnyObject {
    
    var view: CollectionViewProtocol? { get set }
    func viewDidLoad()
    func numberOfRowInSection() -> Int
    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func convertModel()
    
}

//MARK: - Presenter
 final class CollectionViewPresenter: CollectionPresenterProtocol {
    
    //MARK: - Properties
    weak var view: CollectionViewProtocol?
    private var model: [CollectionViewCustomCellModel] = []
    
    //MARK: - Methods
     
    func viewDidLoad() {
        
        createTableDatabase()
        view?.setupCollectionView()
        
    }
    
    func numberOfRowInSection() -> Int {
        return model.count
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCustomCell", for: indexPath) as? CollectionViewCustomCell
        guard let cell = cell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.model = CollectionViewCustomCellModel(id: model[indexPath.row].id,
                                                   description: model[indexPath.row].description,
                                                   image: model[indexPath.row].image)
        
        cell.updateContent()
        return cell
        
    }
    
    func convertModel() {
        
        convertModel { [weak self] data in
            self?.model = data
            self?.view?.reloadCollectionView()
            
        }
    }
    
    private func createTableDatabase() {
        
        let database = SQLDatabase.shared
        database.createTableDatabase()
        
    }
    
    private func convertModel(completion: @escaping ([CollectionViewCustomCellModel]) -> Void) {
        
        let dataModel: [DatabaseModel] = SQLCommands.presentRows() ?? []
        var cellModel: [CollectionViewCustomCellModel] = []
        
        dataModel.forEach {
            let string = String(decoding: $0.image, as: UTF8.self)
            cellModel.append(CollectionViewCustomCellModel(id: $0.id,
                                                           description: $0.description,
                                                           image: string))
        }
        completion(cellModel)
    }
}

//MARK: - Extensions
extension CollectionViewPresenter: CollectionViewCustomCellProtocol {
    
    func didPressDeleteButton(model: CollectionViewCustomCellModel) {
        
        SQLCommands.deleteRow(dataId: model.id)
        self.convertModel { [weak self] data in
            self?.model = data
            self?.view?.reloadCollectionView()
            
        }
    }
}
