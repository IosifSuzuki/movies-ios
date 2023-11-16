//
//  BaseViewController.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa
import AVKit

class BaseViewController<VM: BaseViewModel & ViewModel>: UIViewController, ThemeDependency {
  
  var viewModel: VM!
  var theme: Theme!
  
  var disposeBag = DisposeBag()
  
  private let loaderView = HorizontalGradientLoader()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .darkContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    bindToViewModel()
    apply(theme: theme)
  }
  
  // MARK: - ThemeDependency
  
  func apply(theme: Theme) {
    view.backgroundColor = theme.backgroundColor
  }
  
  // MARK: - Internal
  
  func bindToViewModel() {
    viewModel
      .alertDriver
      .drive(onNext: { [weak self] alert in
        guard let self else {
          return
        }
        self.showAlert(title: alert.title, message: alert.description)
      })
      .disposed(by: disposeBag)
    
    viewModel
      .loadingIndicatorDriver
      .drive { [weak self] isLoading in
        if isLoading {
          self?.loaderView.startAnimation()
        } else {
          self?.loaderView.stopAnimation()
        }
      }.disposed(by: disposeBag)
  }
  
  func setupView() {
    title = viewModel.title
    navigationItem.backButtonDisplayMode = .minimal
    
    setupLoader()
  }
  
  func playVideo(remoteURL: URL) {
    let player = AVPlayer(url: remoteURL)
    let playerViewController = AVPlayerViewController()
    playerViewController.player = player
    
    present(playerViewController, animated: true) {
      player.play()
    }
    
  }
  
  func showAlert(title: String?, message: String?) {
    let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: L10n.cancel, style: .cancel)
    
    alert.addAction(cancelAction)
    
    present(alert, animated: true)
  }
  
  // MARK: - Static methods
  
  class func initialize() -> Self {
    guard let viewController = Assembler.shared.resolver.resolve(Self.self) else {
      fatalError("register your controler in Assembler")
    }
    return viewController
  }
  
  // MARK: - Private methods
  
  private func setupLoader() {
    view.addSubview(loaderView)
    
    loaderView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: loaderView.topAnchor),
      self.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: loaderView.leadingAnchor),
      self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: loaderView.trailingAnchor),
      loaderView.heightAnchor.constraint(equalToConstant: 3)
    ])
    
    let gradientColors = UIColor.linearGradientColors(
      from: Asset.Colors.Loader.startColorGradient.color, 
      to: Asset.Colors.Loader.endColorGradient.color,
      length: 50
    ) + UIColor.linearGradientColors(
      from: Asset.Colors.Loader.endColorGradient.color, 
      to: Asset.Colors.Loader.startColorGradient.color, 
      length: 50
    )
    loaderView.duration = 0.01
    loaderView.colors = gradientColors
  }
  
}
