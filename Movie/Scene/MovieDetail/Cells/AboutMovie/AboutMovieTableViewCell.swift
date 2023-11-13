//
//  AboutMovieTableViewCell.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import UIKit

class AboutMovieTableViewCell: BaseTableViewCell {
  
  @IBOutlet private weak var aboutMovieLabel: UILabel!
  
  override func apply(theme: Theme) {
    super.apply(theme: theme)
    
  }
  
  func setup(viewModel: AboutMovieViewModel) {
    guard let theme else {
      fatalError("set theme before call the method")
    }
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.firstLineHeadIndent = 16
    paragraphStyle.lineSpacing = 2
    aboutMovieLabel.attributedText = NSAttributedString(
      string: viewModel.description,
      attributes: [
        .paragraphStyle: paragraphStyle,
        .font: theme.font(style: .regular, size: 15),
        .foregroundColor: theme.subtitleColor
      ]
    )
    aboutMovieLabel.font = theme.font(style: .regular, size: 14)
    aboutMovieLabel.textColor = theme.subtitleColor
  }
  
}
