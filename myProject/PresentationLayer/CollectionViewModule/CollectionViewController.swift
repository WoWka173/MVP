//
//  ViewController.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import UIKit
import SnapKit

final class CollectionViewController: UIViewController {

    //MARK: - Properties
    private var presenter: CollectionPresenterProtocol
    
    private lazy var customCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 70
        layout.itemSize = CGSize(width: view.frame.size.width/1.3, height: view.frame.size.height/1.8)
        let customCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        customCollectionView.register(CollectionViewCustomCell.self, forCellWithReuseIdentifier: CollectionViewCustomCell.indetifire)
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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()
        setupCollectionView()
        customCollectionView.dataSource = self
        navigationItem.title = "Likes"
        view.layoutSubviews()
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        reloadCollectionView()
        presenter.convertModel()
        
    }
}

//MARK: - Extensions
extension CollectionViewController: CollectionViewProtocol {
    
    func setupCollectionView() {
        
        view.addSubview(customCollectionView)
        customCollectionView.backgroundColor = .white
        customCollectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(100)
            make.top.equalToSuperview()
            
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



