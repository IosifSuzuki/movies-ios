//
//  FullScreenImageViewController.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import UIKit

class FullScreenImageViewController: BaseViewController<FullScreenImageViewModel> {
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    .portrait
  }
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.contentInsetAdjustmentBehavior = .never
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.bouncesZoom = true
    scrollView.bounces = true
    scrollView.alwaysBounceVertical = true
    scrollView.alwaysBounceHorizontal = true
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    
    return scrollView
  }()
  
  private let contentImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureBehaviour()
  }
  
  override func apply(theme: Theme) {
    super.apply(theme: theme)
    
    view.backgroundColor = .clear
  }
  
  override func bindToViewModel() {
    super.bindToViewModel()
    
    contentImageView.image = viewModel.image
  }
  
  override func setupView() {
    super.setupView()
    
    view.addSubview(scrollView)
    scrollView.addSubview(contentImageView)
    
    NSLayoutConstraint.activate([
      view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      view.topAnchor.constraint(equalTo: scrollView.topAnchor),
      view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
    ])
    
    NSLayoutConstraint.activate([
      scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: contentImageView.leadingAnchor),
      scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: contentImageView.topAnchor),
      scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: contentImageView.bottomAnchor),
      scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: contentImageView.trailingAnchor)
    ])
  }
  
  private func configureBehaviour() {
    scrollView.setNeedsLayout()
    scrollView.layoutIfNeeded()
    
    scrollView.delegate = self
    scrollView.minimumZoomScale = 1.0
    scrollView.maximumZoomScale = 3.0
    
    let adjustScale = max(scrollView.bounds.width / viewModel.image.size.width,
                          scrollView.bounds.height / viewModel.image.size.height)
    scrollView.zoomScale = adjustScale
    scrollView.contentOffset = CGPoint(x: (adjustScale * view.bounds.width - viewModel.image.size.width) / 2,
                                       y: .zero)
    
    let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(zoomMaxMin))
    doubleTapGestureRecognizer.numberOfTapsRequired = 2
    scrollView.addGestureRecognizer(doubleTapGestureRecognizer)
  }
  
  @objc private func zoomMaxMin(_ sender: UITapGestureRecognizer) {
    if scrollView.zoomScale == scrollView.maximumZoomScale {
      scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
    } else {
      scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
    }
  }
}

// MARK: UIScrollViewDelegate
extension FullScreenImageViewController: UIScrollViewDelegate {
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    contentImageView
  }
  
}
