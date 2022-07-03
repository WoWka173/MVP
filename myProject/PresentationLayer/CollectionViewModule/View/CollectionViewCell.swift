//
//  CollectionViewCell.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

//MARK: - Protocol
protocol CollectionViewCustomCellProtocol: AnyObject {
    func didPressDeleteButton(model: CollectionViewCustomCellModel)
}

//MARK: Model
struct CollectionViewCustomCellModel {
    
    let id: String
    let description: String
    let image: String
    
}

final class CollectionViewCustomCell: UICollectionViewCell {
    
    static let indetifire = "CollectionViewCustomCell"
    
    //MARK: - Properties
    var model: CollectionViewCustomCellModel?
    weak var delegate: CollectionViewCustomCellProtocol?
    private var isSelectedButton = false
    
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
    
    lazy var deleteButton: UIButton = {
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        deleteButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return deleteButton
        
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupCell()
        setupDescriptionLabel()
        setupDeleteButton()
        setupPictureImage()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Methods
    func updateContent() {
        
        self.pictureImage.kf.setImage(with: URL(string: model?.image ?? ""), placeholder: nil)
        descriptionLabel.text = self.model?.description
        
    }
    
    private func setupCell() {
        
        contentView.backgroundColor = .white
        clipsToBounds = false
        contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        setupPictureImage()
        setupDescriptionLabel()
        setupDeleteButton()
        
    }
    
    private func setupPictureImage() {
        
        addSubview(pictureImage)
        pictureImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.right.left.bottom.equalToSuperview()
            
        }
    }
    
    private func setupDescriptionLabel() {
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureImage.snp.bottom).offset(25)
            make.right.left.equalToSuperview().inset(10)
            
        }
    }
    
    private func setupDeleteButton() {
        
        addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            
        }
    }
    
    @objc private func deleteButtonTapped() {
        
        isSelectedButton.toggle()
        guard let model = model else { return }
        delegate?.didPressDeleteButton(model: model)
        
    }
}
