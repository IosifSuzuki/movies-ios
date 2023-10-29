//
//  MovieItemTableViewCell.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit
import Kingfisher

final class MovieItemTableViewCell: BaseTableViewCell {
  
  @IBOutlet private weak var rootView: UIView!
  @IBOutlet private weak var posterImageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var genresLabel: UILabel!
  @IBOutlet private weak var ratingLabel: UILabel!
  
  override func apply(theme: Theme) {
    super.apply(theme: theme)
    
    titleLabel.font = theme.font(style: .bold, size: 32)
    titleLabel.textColor = theme.titleColor
    genresLabel.font = theme.font(style: .regular, size: 14)
    genresLabel.textColor = theme.subtitleColor
    ratingLabel.font = theme.font(style: .regular, size: 14)
    ratingLabel.textColor = theme.subtitleColor
  }
  
  // MARK: - Internal
  
  func setup(viewModel: MovieItemViewModel) {
    posterImageView.kf.setImage(with: viewModel.posterURL, options: [
      .transition(.fade(1)),
      .cacheOriginalImage
    ])
    titleLabel.text = "\(viewModel.title) \(viewModel.yearText)"
    genresLabel.text = viewModel.genresText
    ratingLabel.text = viewModel.avarageRatingText
  }
  
}
