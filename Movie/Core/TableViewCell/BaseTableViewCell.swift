//
//  BaseTableViewCell.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell, ThemeDependency, Identify {
  
  var theme: Theme?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    selectionStyle = .none
  }
  
  func apply(theme: Theme) {
    self.theme = theme
    backgroundConfiguration = .clear()
    backgroundConfiguration?.backgroundColor = theme.backgroundColor
  }
  
}
