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
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 50
        layout.itemSize = CGSize(width: view.frame.size.width/1.5, height: view.frame.size.height/2)
        let customCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        customCollectionView.register(CollectionViewCustomCell.self, forCellWithReuseIdentifier: "CollectionViewCustomCell")
        return customCollectionView
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
        setupCollectionView()
        customCollectionView.dataSource = self
        navigationItem.title = "Favorites"
        view.layoutSubviews()
        view.backgroundColor = .green
        
    }
}

//MARK: - Extensions
extension CollectionViewController: CollectionViewProtocol {
    
    func setupCollectionView() {
        view.addSubview(customCollectionView)
        customCollectionView.backgroundColor = .green
        customCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(25)
            make.top.equalToSuperview().inset(1)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.customCollectionView.reloadData()
        }
        
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


