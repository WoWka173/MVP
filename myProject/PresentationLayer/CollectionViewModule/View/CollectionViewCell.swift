//
//  CollectionViewCell.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import UIKit
import SnapKit

struct CollectionViewCustomCellModel {
    
    let name: String
    let image: UIImage
}

final class CollectionViewCustomCell: UICollectionViewCell {
    
    //MARK: - Properties
    var model: CollectionViewCustomCellModel?
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 15)
        return nameLabel
    }()
    
    private lazy var productImage: UIImageView = {
       let productImage = UIImageView()
        productImage.clipsToBounds = true
        productImage.contentMode = .scaleAspectFit
       return productImage
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Methods
    func setContent() {
        nameLabel.text = self.model?.name
        productImage.image = self.model?.image
    }
    
    private func setupCell(){
        contentView.backgroundColor = .white
        clipsToBounds = false
        contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        setupProductImage()
        setupNameLabel()
    }
    
    private func setupProductImage(){
        addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(25)
            make.right.left.equalToSuperview().inset(10)
        }
    }
}
