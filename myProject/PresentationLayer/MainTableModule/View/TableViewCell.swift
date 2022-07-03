//
//  TableViewCell.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

struct TableViewCellModel {
    
    let id: String
    let description: String
    let image: String
    
}

protocol TableViewCellProtocol: AnyObject {
    
    func didPressTableViewCellLikeButton(isSelected: Bool, model: TableViewCellModel)
    
}

final class TableViewCell: UITableViewCell {

    //MARK: - Properties
    var model: TableViewCellModel?
    weak var delegate: TableViewCellProtocol?
    var isSelectedButton = false
    
    private lazy var descriptionLable: UILabel = {
        
        let descriptionLable = UILabel()
        descriptionLable.numberOfLines = 0
        descriptionLable.font = .systemFont(ofSize: 20)
        descriptionLable.textAlignment = .center
        descriptionLable.textColor = .black
        return descriptionLable
        
    }()
    
    private lazy var pictureImage: UIImageView = {
        
        let pictureImage = UIImageView()
        pictureImage.contentMode = .scaleAspectFill
        pictureImage.layer.masksToBounds = true
        pictureImage.layer.cornerRadius = 30
        return pictureImage
        
    }()
    
    lazy var likeButton: UIButton = {
        
        let likeButton = UIButton(type: .system)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        likeButton.tintColor = .gray
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return likeButton
        
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryView = likeButton
        setupPictureImage()
        setupDescriptionLabel()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    override func prepareForReuse() {
        
        super.prepareForReuse()
        isSelectedButton = false
        likeButton.tintColor = .gray
        
    }
    
    func updateContent() {
        
        descriptionLable.text = self.model?.description
        self.pictureImage.kf.setImage(with: URL(string: model?.image  ?? ""), placeholder: nil)
        
    }
    
    private func setupPictureImage() {
        
        addSubview(pictureImage)
        pictureImage.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(10)
            make.height.equalTo(150)
            make.width.equalTo(160)
            
        }
    }
    
    private func setupDescriptionLabel() {
        
        addSubview(descriptionLable)
        descriptionLable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(pictureImage.snp.right).offset(10)
            make.right.equalToSuperview().inset(65)
            make.bottom.equalToSuperview().inset(10)
            
        }
    }
    
@objc func likeButtonTapped() {
    
    isSelectedButton.toggle()
    likeButton.tintColor = isSelectedButton ? .red : .gray
    guard let model = model else { return }
    delegate?.didPressTableViewCellLikeButton(isSelected: isSelectedButton, model: model)
    
    }
}
