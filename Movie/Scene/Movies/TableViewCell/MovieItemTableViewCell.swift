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
  
  private var downloadImageTask: DownloadTask?
  private var viewModel: MovieItemViewModel?
  
  var width: CGFloat {
    guard let keyWindow = UIApplication.shared.currentWindow else {
      return .zero
    }
    
    return keyWindow.screen.bounds.width - 32
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    posterImageView.layer.cornerRadius = 3
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    
    guard let previousTraitCollection,
            previousTraitCollection.verticalSizeClass != traitCollection.verticalSizeClass ||
            previousTraitCollection.horizontalSizeClass != traitCollection.horizontalSizeClass else {
      return
    }
    
    if let viewModel {
      setup(viewModel: viewModel)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    applyTextColor(to: false)
  }
  
  override func apply(theme: Theme) {
    super.apply(theme: theme)
    
    titleLabel.font = theme.font(style: .bold, size: 32)
    genresLabel.font = theme.font(style: .regular, size: 14)
    ratingLabel.font = theme.font(style: .regular, size: 14)
    
    applyTextColor(to: false)
  }
  
  // MARK: - Internal
  
  func setup(viewModel: MovieItemViewModel) {
    self.viewModel = viewModel
    downloadImageTask?.cancel()
    
    guard let posterURL = viewModel.posterURL(by: width) else {
      return
    }
    posterImageView.contentMode = .top
    downloadImageTask = KingfisherManager.shared.retrieveImage(with: posterURL, options: [.cacheOriginalImage]) { [weak self] result in
      guard let self else {
        return
      }
      switch result {
      case let .success(imageResult):
        self.posterImageView.image = imageResult.image.resizeTopAlignedToFill(newWidth: self.width)
        self.addShadow()
        self.applyTextColor(to: imageResult.image.isDark)
        
        self.titleLabel.text = "\(viewModel.title)"
        if let yearText = viewModel.yearText {
          self.titleLabel.text?.append(" \(yearText)")
        }
        self.genresLabel.text = viewModel.genresText
        self.ratingLabel.text = viewModel.avarageRatingText
      case let .failure(error):
        print("error: \(error)")
      }
    }
  }
  
  private func addShadow() {
    rootView.layer.shadowColor = theme?.subtitleColor.cgColor
    rootView.layer.shadowOpacity = 1
    rootView.layer.shadowRadius = 3
    rootView.layer.shadowOffset = .init(width: 0, height: 3)
  }
  
  private func applyTextColor(to darkContent: Bool) {
    titleLabel.textColor = if darkContent {
      theme?.titleColor.inverseColor()
    } else {
      theme?.titleColor
    }
    genresLabel.textColor = if darkContent {
      theme?.subtitleColor.inverseColor()
    } else {
      theme?.subtitleColor
    }
    ratingLabel.textColor = if darkContent {
      theme?.subtitleColor.inverseColor()
    } else {
      theme?.subtitleColor
    }
  }
  
}
