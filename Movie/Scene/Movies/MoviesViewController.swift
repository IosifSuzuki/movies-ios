//
//  Movies.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

final class MoviesViewController: BaseViewController<MoviesViewModel> {
  
  @IBOutlet private weak var tableView: UITableView!
  private weak var sortByBarButtonItem: UIBarButtonItem?
  
  private var emptyStateView: EmptyStateTableView?
  
  private var searchController: UISearchController!
  private var searchTextField: UISearchTextField {
    searchController.searchBar.searchTextField
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.refreshData()
  }
  
  override func bindToViewModel() {
    super.bindToViewModel()
    
    guard let sortByTrigger = sortByBarButtonItem?.rx.tap.asDriver() else {
      fatalError("sortByBarButtonItem must already be initialized")
    }
    
    let searchTrigger = searchController
      .searchBar
      .rx
      .text
      .throttle(.seconds(1), latest: true, scheduler: MainScheduler.asyncInstance)
      .asDriver(onErrorDriveWith: Driver<String?>.empty())
    
    emptyStateView?.setup(viewModel: viewModel.emptyStateViewModel)
    
    let input = MoviesViewModel.Input(
      sortByTrigger: sortByTrigger, 
      searchTrigger: searchTrigger
    )
    
    let output = viewModel.transform(input: input)
    
    output.refreshViewTrigger.drive(onNext: { [weak self] _ in
      self?.tableView.refreshControl?.endRefreshing()
      self?.tableView.setContentOffset(.zero, animated: true)
      self?.tableView.reloadData()
    }).disposed(by: disposeBag)
    
    output.sortByTrigger.drive(onNext: { [weak self] dataSource in
      self?.showActionSheet(dataSource: dataSource)
    }).disposed(by: disposeBag)
    
    output.movieDetailTrigger.drive(onNext: { [weak self] movieID in
      guard let viewController = Assembler.shared.resolver.resolve(MovieDetailViewController.self, argument: movieID) else {
        fatalError("MovieDetailViewController has failed resolved")
      }
      
      self?.navigationController?.pushViewController(viewController, animated: true)
    }).disposed(by: disposeBag)
    
  }
  
  override func apply(theme: Theme) {
    super.apply(theme: theme)
    
    tableView.backgroundColor = theme.backgroundColor
    tableView.separatorColor = theme.titleColor
    
    let searchBarTextColor = theme.titleColor
    let searchBarFont = theme.font(style: .regular, size: 14)
    searchTextField.textColor = theme.titleColor
    searchTextField.leftView?.tintColor = searchBarTextColor
    searchTextField.font = searchBarFont
    searchTextField.attributedPlaceholder = .init(string: L10n.search, attributes: [
      .font: searchBarFont,
      .foregroundColor: searchBarTextColor
    ])
    tableView.refreshControl?.tintColor = theme.titleColor
    
    navigationItem.rightBarButtonItem?.tintColor = theme.titleColor
    
    emptyStateView?.apply(theme: theme)
  }
  
  override func setupView() {
    super.setupView()
    
    tableView.registerCell(forClass: MovieItemTableViewCell.self)
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
    tableView.contentInset.bottom = view.safeAreaInsets.bottom
    
    emptyStateView = EmptyStateTableView(frame: .zero)
    tableView.backgroundView = emptyStateView
    
    searchController = UISearchController()
    searchController.searchBar.delegate = self
    
    let rightBarButtonItem = UIBarButtonItem(image: Asset.Media.icFilter.image, style: .plain, target: nil, action: nil)
    sortByBarButtonItem = rightBarButtonItem
    navigationItem.rightBarButtonItem = rightBarButtonItem
    navigationItem.searchController = searchController
  }
  
  // MARK: - Action
  
  @objc func refresh(_ control: UIRefreshControl) {
    viewModel.refreshData()
  }
  
  private func showActionSheet(dataSource: [MovieSortByItem]) {
    let alertViewController = UIAlertController(title: L10n.MoviesViewController.SortBy.text, message: nil, preferredStyle: .actionSheet)
    
    dataSource.map { movieSortByItem in
      let alertAction = UIAlertAction(title: movieSortByItem.title, style: .default) { [weak self] _ in
        self?.viewModel.select(movieSortByItem: movieSortByItem)
        
        alertViewController.dismiss(animated: true)
      }
      alertAction.setValue(movieSortByItem.isSelected, forKey: "checked")
      
      return alertAction
    }.forEach { alertAction in
      alertViewController.addAction(alertAction)
    }
    
    let cancelAction = UIAlertAction(title: L10n.cancel, style: .cancel)
    alertViewController.addAction(cancelAction)
    
    self.present(alertViewController, animated: true)
  }
  
  enum Defaults {
    static let heightOfCell: CGFloat = 200
  }
  
}

// MARK: - UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(forClass: MovieItemTableViewCell.self, indexPath: indexPath)
    let viewModel = viewModel.dataSource.item(by: indexPath)
    cell.apply(theme: theme)
    switch viewModel {
    case let viewModel as MovieItemViewModel:
      cell.setup(viewModel: viewModel)
    default:
      break
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let rows = viewModel.dataSource.numberOfRows(in: section)
    tableView.backgroundView?.isHidden = rows > 0
    
    return rows
  }
  
}

// MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    Defaults.heightOfCell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    viewModel.scroll(to: indexPath)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let viewModel = viewModel.dataSource.item(by: indexPath) as? MovieItemViewModel {
      self.viewModel.select(movieItem: viewModel)
    }
  }
  
}

// MARK: - UISearchBarDelegate
extension MoviesViewController: UISearchBarDelegate {
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    viewModel.shouldBeginEditingSearchBar()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.cancelSearch()
  }
  
}
