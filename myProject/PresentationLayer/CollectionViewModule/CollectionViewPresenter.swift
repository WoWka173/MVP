//
//  CollectionViewPresenter.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import Foundation
import UIKit

//MARK: Protocols
protocol CollectionViewProtocol: AnyObject {
    func setupCollectionView()
    func reloadCollectionView()
}

protocol CollectionPresenterProtocol: AnyObject {
    var view: CollectionViewProtocol? { get set }
    func viewDidLoad()
    func numberOfRowInSection() -> Int
    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

//MARK: - Presenter
final class CollectionPresenter: CollectionPresenterProtocol {
    
    //MARK: - Properties
    weak var view: CollectionViewProtocol?
    private var service: Database?
    private var model: [TableViewCellModel] = []
    
    //MARK: - unit
    init() {
        self.service = Database()
    }
    
    //MARK: Methods
    func viewDidLoad() {
        model = Database.shared.modelDB
        view?.setupCollectionView()
    }
    
    func numberOfRowInSection() -> Int {
        return model.count
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCustomCell", for: indexPath) as? CollectionViewCustomCell
        guard let collectionView = cell else { return UICollectionViewCell() }
        
        collectionView.model = CollectionViewCustomCellModel(description: model[indexPath.row].description, image: model[indexPath.row].image)
        
        collectionView.updateContent()
        return collectionView
    }
}
