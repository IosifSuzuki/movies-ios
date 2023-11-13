//
//  PosterTableViewCell.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import UIKit
import Kingfisher

class PosterTableViewCell: BaseTableViewCell {
  @IBOutlet private weak var posterImageView: UIImageView!
  
  private var downloadImageTask: DownloadTask?
  private var logger: Logger?
  
  func setup(viewModel: PosterViewModel, logger: Logger) {
    self.logger = logger
    self.posterImageView.contentMode = .scaleAspectFill
    downloadImageTask?.cancel()
    downloadImageTask = KingfisherManager.shared.retrieveImage(with: viewModel.posterURL, options: [.cacheOriginalImage]) { [weak self] result in
      guard let self else {
        return
      }
      switch result {
      case let .success(imageResult):
        self.posterImageView.image = imageResult.image.resizeTopAlignedToFill(newWidth: self.posterImageView.bounds.width)
      case let .failure(error):
        self.logger?.error(message: "download image by source", err: error)
      }
    }
  }
  
}
