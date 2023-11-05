//
//  Movies.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit
import Swinject

final class MoviesViewController: BaseViewController<MoviesViewModel> {
  
  @IBOutlet private weak var tableView: UITableView!
  
  var searchController: UISearchController!
  var searchTextField: UISearchTextField {
    searchController.searchBar.searchTextField
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.fetchData()
  }
  
  override func bindToViewModel() {
    super.bindToViewModel()
    
    let input = MoviesViewModel.Input()
    let output = viewModel.transform(input: input)
    output.refreshViewTrigger.drive(onNext: { [weak self] _ in
      self?.tableView.reloadData()
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
  }
  
  override func setupView() {
    super.setupView()
    
    tableView.registerCell(forClass: MovieItemTableViewCell.self)
    
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = .init(string: "Refresh")
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    searchController = UISearchController()
    searchController.obscuresBackgroundDuringPresentation = true
    searchController.searchBar.showsCancelButton = false
    
    let rightBarButtonItem = UIBarButtonItem(image: Asset.Media.icFilter.image, style: .plain, target: nil, action: nil)
    navigationItem.rightBarButtonItem = rightBarButtonItem
    navigationItem.searchController = searchController
  }
  
  enum Defaults {
    static let heightOfCell: CGFloat = 200
  }
  
  @objc func refresh(_ control: UIRefreshControl) {
    control.endRefreshing()
  }
}

// MARK: - UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(forClass: MovieItemTableViewCell.self, indexPath: indexPath)
    let itemViewModel = viewModel.dataSource[indexPath.row]
    
    cell.apply(theme: theme)
    cell.setup(viewModel: itemViewModel)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.dataSource.count
  }
  
}

// MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    Defaults.heightOfCell
  }
  
}
