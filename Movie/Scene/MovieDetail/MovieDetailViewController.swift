//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import UIKit

final class MovieDetailViewController: BaseViewController<MovieDetailViewModel> {
  
  @IBOutlet private weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.fetchData()
  }
  
  override func apply(theme: Theme) {
    super.apply(theme: theme)
    
    tableView.backgroundColor = theme.backgroundColor
  }
  
  override func setupView() {
    super.setupView()
    
    tableView.registerCell(forClass: PosterTableViewCell.self)
    tableView.registerCell(forClass: MovieInfoTableViewCell.self)
    tableView.registerCell(forClass: AboutMovieTableViewCell.self)
    tableView.registerCell(forClass: MovieRatingTableViewCell.self)
    
    tableView.separatorStyle = .none
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
  
  override func bindToViewModel() {
    super.bindToViewModel()
    
    let input = MovieDetailViewModel.Input()
    let output = viewModel.transform(input: input)
    
    output.refreshViewTrigger.drive(onNext: { [weak self] _ in
      self?.tableView.refreshControl?.endRefreshing()
      
      self?.tableView.reloadData()
    }).disposed(by: disposeBag)
    
    output.titleTrigger.drive(rx.title).disposed(by: disposeBag)
  }
  
  // MARK: - Actions
  
  @IBAction func refresh() {
    viewModel.fetchData()
  }
  
}

extension MovieDetailViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellType = viewModel.dataSource[indexPath.row]
    switch cellType {
    case let .movieInfo(viewModel: movieInfoViewModel):
      let cell = tableView.dequeueReusableCell(forClass: MovieInfoTableViewCell.self, indexPath: indexPath)
      cell.apply(theme: theme)
      cell.setup(viewModel: movieInfoViewModel)
      
      return cell
    case let .poster(viewModel: posterViewModel):
      let cell = tableView.dequeueReusableCell(forClass: PosterTableViewCell.self, indexPath: indexPath)
      cell.apply(theme: theme)
      cell.setup(viewModel: posterViewModel)
      
      return cell
    case let .about(viewModel: viewModel):
      let cell = tableView.dequeueReusableCell(forClass: AboutMovieTableViewCell.self, indexPath: indexPath)
      cell.apply(theme: theme)
      cell.setup(viewModel: viewModel)
    
      return cell
    case let .rating(viewModel: viewModel):
      let cell = tableView.dequeueReusableCell(forClass: MovieRatingTableViewCell.self, indexPath: indexPath)
      cell.apply(theme: theme)
      cell.setup(viewModel: viewModel)
      
      cell.watchTrailerDriver.drive(onNext: { [weak self] _ in
        self?.playVideo(remoteURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)
      }).disposed(by: disposeBag)
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.dataSource.count
  }
  
}

extension MovieDetailViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    viewModel.dataSource[indexPath.row].height
  }
  
}
