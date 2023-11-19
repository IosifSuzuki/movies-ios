//
//  EmptyStateTableView.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import UIKit

final class EmptyStateTableView: UIView, ThemeDependency {
  
  private var titleLabel: UILabel = {
    let label = UILabel()
    
    return label
  }()
  
  private var subtitleLabel: UILabel = {
    let label = UILabel()
    
    return label
  }()
  
  var contentView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 14
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    
  }
  
  // MARK: - Internal
  
  func setup(viewModel: EmptyStateViewModel) {
    titleLabel.text = viewModel.title
    subtitleLabel.text = viewModel.subtitle
  }
  
  // MARK: - ThemeDependency
  
  func apply(theme: Theme) {
    backgroundColor = theme.backgroundColor
    titleLabel.textColor = theme.accentColor
    titleLabel.font = theme.font(style: .medium, size: 20)
    subtitleLabel.textColor = theme.subtitleColor
    subtitleLabel.font = theme.font(style: .regular, size: 18)
  }
  
  private func setupView() {
    contentView.addArrangedSubview(titleLabel)
    contentView.addArrangedSubview(subtitleLabel)
    addSubview(contentView)
    
    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 32),
      contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
      contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
      contentView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 32)
    ])
  }
}
