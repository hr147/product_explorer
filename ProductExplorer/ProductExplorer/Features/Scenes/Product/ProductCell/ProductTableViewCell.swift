//
//  ProductTableViewCell.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit
import UIElements

final class ProductTableViewCell: UITableViewCell {
    // MARK: - Private Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirDemiBold, size: .standard(.h4))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let userTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirRegular, size: .standard(.h6))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let albumArtImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    // MARK: - Public Methods
    
    func configure(with viewModel: ProductCellViewModel) {
        nameLabel.text = viewModel.name
        userTypeLabel.text = viewModel.userType
        albumArtImageView.setImage(with: viewModel.imageURL, placeholder: viewModel.placeHolderImage)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(mainStackView)
        [nameLabel, userTypeLabel].forEach(infoStackView.addArrangedSubview(_:))
        [albumArtImageView, infoStackView].forEach(mainStackView.addArrangedSubview(_:))
    }
    
    private func setupConstraints() {
        mainStackView.layout {
            $0.leading == contentView.leadingAnchor + 8
            $0.trailing == contentView.trailingAnchor - 8
            $0.top == contentView.topAnchor + 16
            $0.bottom == contentView.bottomAnchor
        }
        
        albumArtImageView.layout {
            $0.width.equal(to: 75)
            $0.height.equal(to: 100)
        }
    }
    
    private func configureViews() {
        selectionStyle = .none
    }
}
