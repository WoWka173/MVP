//
//  TableViewCell.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import UIKit
import SnapKit

struct TableViewCellModel {
    
    let name: String
    let description: String
    let image: UIImage
}

final class TableViewCell: UITableViewCell {

    //MARK: - Properties
    var model: TableViewCellModel?
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.textColor = .black
        return nameLabel
    }()
    
    private lazy var descriptionLable: UILabel = {
        let descriptionLable = UILabel()
        descriptionLable.numberOfLines = 0
        descriptionLable.font = .systemFont(ofSize: 25)
        descriptionLable.textColor = .black
        return descriptionLable
    }()
    
    private lazy var pictureImage: UIImageView = {
        let pictureImage = UIImageView()
        pictureImage.contentMode = .scaleAspectFit
        return pictureImage
    }()
    
    private lazy var favoriteButton: UIButton = {
        let favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteButton.tintColor = .red
        accessoryView = favoriteButton
        favoriteButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        return favoriteButton
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupImageView()
        setupLabel()
        setupDescriptionLabel()
        setupFavoritesButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //MARK: - Methods
    func updateContent() {
        nameLabel.text = self.model?.name
        descriptionLable.text = self.model?.description
        pictureImage.image = self.model?.image
    }
    
    private func setupImageView() {
        addSubview(pictureImage)
        pictureImage.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(10)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }
    
    private func setupLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(pictureImage.snp.right).offset(10)
            make.top.equalToSuperview().inset(10)
        }
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLable)
        descriptionLable.snp.makeConstraints { make in
            make.left.equalTo(pictureImage.snp.right).offset(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
    
    private func setupFavoritesButton () {
        addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(30)
        }
    }
    @objc
    func tappedButton() {
        print("tapped")
    }
}
