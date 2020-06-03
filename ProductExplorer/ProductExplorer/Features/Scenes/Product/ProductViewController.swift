//
//  ProductViewController.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit
import Combine

final class ProductViewController: UITableViewController {
    private lazy var dataSource = makeDataSource()
    private var cancellable: [AnyCancellable] = []
    private let productTriggered = PassthroughSubject<Void, Never>()
    private lazy var notifyViewController = NotifyViewController()
    
    private let viewModel: ProductViewModel
    
    // MARK: - Init
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        productTriggered.send(())
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        definesPresentationContext = true
        title = viewModel.screenTitle
        
        tableView.registerClass(cellClass: ProductTableViewCell.self)
        tableView.dataSource = dataSource
        
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        add(notifyViewController)
        notifyViewController.showNotification(for: .startNotificationViewModel())
        
        let all = UIBarButtonItem(title: "All", style: .plain, target: nil, action: nil)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let available = UIBarButtonItem(title: "Available", style: .plain, target: nil, action: nil)
        let favorite = UIBarButtonItem(title: "Favorite", style: .plain, target: nil, action: nil)
        toolbarItems = [all, spacer, available, spacer, favorite]
        
        
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    private func bindViewModel() {
        let input = ProductViewModelInput(productTriggered: productTriggered.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellable)
    }
    
    private func render(_ state: ProductViewModelState) {
        switch state {
        case .noResults:
            notifyViewController.view.isHidden = false
            notifyViewController.showNotification(for: .emptyNotificationViewModel())
            update(with: [], animate: true)
        case .error(let error):
            notifyViewController.view.isHidden = false
            notifyViewController.showNotification(for: .errorNotificationViewModel(with: error))
            update(with: [], animate: true)
        case .show(let users):
            notifyViewController.view.isHidden = true
            update(with: users, animate: true)
        }
    }
}

fileprivate extension ProductViewController {
    enum Section: CaseIterable {
        case products
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, ProductCellViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, userViewModel in
                let cell: ProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configure(with: userViewModel)
                return cell
        })
    }
    
    func update(with movies: [ProductCellViewModel], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, ProductCellViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(movies, toSection: .products)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}
