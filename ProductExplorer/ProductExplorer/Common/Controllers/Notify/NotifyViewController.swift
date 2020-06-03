//
//  NotifyViewController.swift
//  RepoUserExplorer
//
//  Created by Haroon Ur Rasheed on 02/05/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit


/// `NotifyViewController` responsible to show alert or messages.
final class NotifyViewController: UIViewController {
    // MARK: - Private Properties
    
    private lazy var notifyView = NotifyView()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Public Methods
    
    override func loadView() {
        super.loadView()
        view = notifyView
    }
    
    func showNotification(for viewModel: NotifyViewModel) {
        notifyView.titleLabel.text = viewModel.title
        notifyView.notificationLabel.text = viewModel.notification
        notifyView.notificationImageView.image = viewModel.image
    }
}
