//
//  MovieRatingTableViewCell.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import UIKit
import RxCocoa

class MovieRatingTableViewCell: BaseTableViewCell {
  
  @IBOutlet private weak var watchTrailerButton: DesignedButton!
  @IBOutlet private weak var ratingLabel: UILabel!
  
  var watchTrailerDriver: Driver<Void> {
    watchTrailerButton.rx.tap.asDriver()
  }
  
  // MARK: - BaseTableViewCell
  
  override func apply(theme: Theme) {
    super.apply(theme: theme)
    
    ratingLabel.textColor = theme.titleColor
    ratingLabel.font = theme.font(style: .regular, size: 16)
    
    watchTrailerButton.baseBackgroundColor = theme.accentColor
    watchTrailerButton.foregroundColor = theme.titleColor
    watchTrailerButton.font = theme.font(style: .regular, size: 16)
  }
  
  // MARK: - Internal
  
  func setup(viewModel: MovieRatingViewModel) {
    watchTrailerButton.setTitle(viewModel.watchTheTrailer, for: .normal)
    ratingLabel.text = viewModel.rating
  }
}
