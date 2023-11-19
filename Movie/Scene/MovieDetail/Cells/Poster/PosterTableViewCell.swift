//
//  PosterTableViewCell.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import UIKit
import Kingfisher

class PosterTableViewCell: BaseTableViewCell {
  @IBOutlet private(set) weak var posterImageView: UIImageView!
  
  private var downloadImageTask: DownloadTask?
  
  func setup(viewModel: PosterViewModel) {
    posterImageView.contentMode = .top
    
    guard let posterURL = viewModel.posterURL(by: posterImageView.bounds.width) else {
      viewModel.logger.error(message: "retrieve poster url has failed")
      return
    }
    
    downloadImageTask?.cancel()
    downloadImageTask = KingfisherManager.shared.retrieveImage(with: posterURL, options: [.cacheOriginalImage]) { [weak self] result in
      guard let self else {
        return
      }
      switch result {
      case let .success(imageResult):
        self.posterImageView.image = imageResult.image.resizeTopAlignedToFill(newWidth: self.posterImageView.bounds.width)
      case let .failure(error):
        viewModel.logger.error(message: "download image by source", err: error)
      }
    }
  }
  
}
