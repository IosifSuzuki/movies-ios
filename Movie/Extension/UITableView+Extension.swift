//
//  UITableView+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit

extension UITableView {
  
  func registerHeaderFooter<T: BaseHeaderFooterView>(forClass classInstance: T.Type) {
    let nibCell = UINib(nibName: classInstance.identifier, bundle: .main)
    register(nibCell, forHeaderFooterViewReuseIdentifier: classInstance.identifier)
  }
  
  func dequeueReusableHeaderFooterView<T: BaseHeaderFooterView>(forClass classInstance: T.Type) -> T {
    guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: classInstance.identifier) as? T else {
      preconditionFailure()
    }
    return headerFooterView
  }
  
  func registerCell<T: BaseTableViewCell>(forClass classInstance: T.Type) {
    let nibCell = UINib(nibName: classInstance.identifier, bundle: .main)
    register(nibCell, forCellReuseIdentifier: classInstance.identifier)
  }
  
  func dequeueReusableCell<T: BaseTableViewCell>(forClass classInstance: T.Type, indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: classInstance.identifier, for: indexPath) as? T else {
      preconditionFailure()
    }
    return cell
  }
  
}
