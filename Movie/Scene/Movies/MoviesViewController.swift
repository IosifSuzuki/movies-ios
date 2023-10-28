//
//  Movies.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit
import Swinject

final class MoviesViewController: BaseViewController<MoviesViewModel> {
  
  @IBOutlet private weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func apply(theme: Theme) {
    super.apply(theme: theme)
    
    tableView.backgroundColor = theme.backgroundColor
  }
  
}
