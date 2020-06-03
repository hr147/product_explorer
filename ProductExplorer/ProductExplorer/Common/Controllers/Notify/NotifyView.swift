//
//  NotifyView.swift
//  RepoUserExplorer
//
//  Created by Haroon Ur Rasheed on 02/05/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit
import UIElements

final class NotifyView: UIView {
    // MARK: - Public Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirDemiBold, size: .standard(.h4))
        label.numberOfLines = 0
        return label
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(color: .standard(.themeColor))
        label.font = .init(.avenirRegular, size: .standard(.h6))
        label.numberOfLines = 0
        return label
    }()
    
    let notificationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Private Properties
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        buildViewHierarchy()
        setupConstraints()
        configureUI()
    }
    
    private func buildViewHierarchy() {
        addSubview(mainStackView)
        
        [notificationImageView, titleLabel, notificationLabel]
            .forEach(mainStackView.addArrangedSubview(_:))
    }
    
    private func setupConstraints() {
        mainStackView.layout {
            $0.leading == leadingAnchor
            $0.trailing == trailingAnchor
            $0.top == safeAreaLayoutGuide.topAnchor + 100
        }
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
}
