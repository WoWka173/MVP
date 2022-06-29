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
    private var service: UserNetwork
    private var model: [Users] = []
    
    //MARK: - unit
    init() {
        self.service = UserNetwork()
    }
    
    //MARK: Methods
    func viewDidLoad() {
        fetchData()
        view?.setupCollectionView()
    }
    
    func numberOfRowInSection() -> Int {
        return model.count
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCustomCell", for: indexPath) as? CollectionViewCustomCell
        guard let collectionView = cell else { return UICollectionViewCell() }
        collectionView.model = CollectionViewCustomCellModel(name: model[indexPath.row].name, image: model[indexPath.row].imageUser)
        collectionView.setContent()
        return collectionView
    }

    private func fetchData() {
        service.fetchUsersData { [weak self] usersdata in
            guard let self = self else { return }
            self.model = usersdata
        }
    }
}
