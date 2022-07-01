//
//  CollectionViewCell.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

struct CollectionViewCustomCellModel {
    
    let description: String
    let image: String
}

final class CollectionViewCustomCell: UICollectionViewCell {
    
    //MARK: - Properties
    var model: CollectionViewCustomCellModel?
    
    private lazy var descriptionLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 15)
        return nameLabel
    }()
    
    private lazy var pictureImage: UIImageView = {
       let pictureImage = UIImageView()
        pictureImage.layer.cornerRadius = 30
        pictureImage.clipsToBounds = true
        pictureImage.contentMode = .scaleAspectFill
       return pictureImage
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
    func updateContent() {
        descriptionLabel.text = self.model?.description
        self.pictureImage.kf.setImage(with: URL(string: model?.image ?? ""), placeholder: nil)
        
    }
    
    private func setupCell(){
        contentView.backgroundColor = .white
        clipsToBounds = false
        contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        setupPictureImage()
        setupNameLabel()
        backgroundColor = .systemGreen
    }
    
    private func setupPictureImage(){
        addSubview(pictureImage)
        pictureImage.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
    }
    
    private func setupNameLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureImage.snp.bottom).offset(25)
            make.right.left.equalToSuperview().inset(10)
        }
    }
}
