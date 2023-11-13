//
//  MovieInfoTableViewCell.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import UIKit

class MovieInfoTableViewCell: BaseTableViewCell {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var subtitleLabel: UILabel!
  @IBOutlet private weak var genresLabel: UILabel!
  
  // MARK: - ThemeDependency
  
  override func apply(theme: Theme) {
    super.apply(theme: theme)
    
    titleLabel.textColor = theme.titleColor
    titleLabel.font = theme.font(style: .bold, size: 16)
    subtitleLabel.textColor = theme.subtitleColor
    subtitleLabel.font = theme.font(style: .medium, size: 14)
    genresLabel.textColor = theme.subtitleColor
    genresLabel.font = theme.font(style: .regular, size: 14)
  }
  
  // MARK: - Internal
  
  func setup(viewModel: MovieInfoViewModel) {
    titleLabel.text = viewModel.title
    subtitleLabel.text = viewModel.subtitle
    genresLabel.text = viewModel.genres
  }
  
}
