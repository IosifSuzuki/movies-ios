//
//  BaseTableViewCell.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell, ThemeDependency, Identify {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    selectionStyle = .none
  }
  
  func apply(theme: Theme) {
    backgroundConfiguration = .clear()
    backgroundConfiguration?.backgroundColor = theme.backgroundColor
  }
  
}
