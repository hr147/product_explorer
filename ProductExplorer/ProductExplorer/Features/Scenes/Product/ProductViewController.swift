//
//  ProductViewController.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit
import Combine

class ProductViewController: UITableViewController {
    private lazy var dataSource = makeDataSource()
    private var cancellable: [AnyCancellable] = []
    
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
        update(with: [.init(),.init(),.init()])
    }
    
    //    override func loadView() {
    //        super.loadView()
    //        view = userSearchView
    //    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        definesPresentationContext = true
        //title = viewModel.screenTitle
        
        tableView.registerClass(cellClass: ProductTableViewCell.self)
        tableView.dataSource = dataSource
        
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        //add(notifyViewController)
        //notifyViewController.showNotification(for: .startNotificationViewModel())
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let camera = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        toolbarItems = [add, spacer, compose,spacer, camera]
        
        
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    private func bindViewModel() {
        //        let input = UserSearchViewModelInput(search: search.eraseToAnyPublisher())
        //
        //        let output = viewModel.transform(input: input)
        //
        //        output.sink(receiveValue: {[unowned self] state in
        //            self.render(state)
        //        }).store(in: &cancellable)
    }
    
    //    private func render(_ state: UserSearchViewModelState) {
    //        switch state {
    //        case .noResults:
    //            notifyViewController.view.isHidden = false
    //            notifyViewController.showNotification(for: .emptyNotificationViewModel())
    //            update(with: [], animate: true)
    //        case .error(let error):
    //            notifyViewController.view.isHidden = false
    //            notifyViewController.showNotification(for: .errorNotificationViewModel(with: error))
    //            update(with: [], animate: true)
    //        case .show(let users):
    //            notifyViewController.view.isHidden = true
    //            update(with: users, animate: true)
    //        }
    //    }
    
    @objc
    func addTapped() {
        
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
