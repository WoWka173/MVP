//
//  ViewController.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController {

    //MARK: - Properties
    private var presenter: CollectionPresenterProtocol
    
    private lazy var customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 50
        layout.itemSize = CGSize(width: view.frame.size.width/2.5, height: view.frame.size.height/3.5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCustomCell.self, forCellWithReuseIdentifier: "CollectionViewCustomCell")
        return collectionView
    }()
    
    //MARK: - Init
    init(presenter: CollectionPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()
        navigationItem.title = "Favorites"
        view.backgroundColor = .systemGray6
    }
}

//MARK: - Extensions
extension CollectionViewController: CollectionViewProtocol {
    
    func setupCollectionView() {
        view.addSubview(customCollectionView)
        customCollectionView.backgroundColor = .systemGray6
        customCollectionView.dataSource = self
        customCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(25)
            make.top.equalToSuperview().inset(1)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func reloadCollectionView() {
        customCollectionView.reloadData()
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfRowInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter.cellForItemAt(collectionView, cellForItemAt: indexPath)
    }
}


