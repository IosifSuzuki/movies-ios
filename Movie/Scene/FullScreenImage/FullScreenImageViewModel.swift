//
//  FullScreenImageViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import Foundation
import UIKit.UIImage

class FullScreenImageViewModel: BaseViewModel, ViewModel {
  var title: String?
  var image: UIImage
  
  init(image: UIImage, networkReachability: NetworkReachability) {
    self.image = image
    
    super.init(networkReachability: networkReachability)
  }
  
  func transform(input: Input) -> Output {
    return Output()
  }
  
  struct Input {
    
  }
  
  struct Output {
    
  }
}
