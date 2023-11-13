//
//  UIImage+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 05.11.2023.
//

import UIKit

extension UIImage {
  
  var isBright: Bool {
    var white: CGFloat = .zero
    self.averageColor?.getWhite(&white, alpha: nil)
    return white > 0.5
  }
  
  var isDark: Bool {
    return !isBright
  }
  
  var averageColor: UIColor? {
    guard let inputImage = CIImage(image: self) else { return nil }
    
    let extentVector = CIVector(x: inputImage.extent.origin.x,
                                y: inputImage.extent.origin.y,
                                z: inputImage.extent.size.width,
                                w: inputImage.extent.size.height)
    
    guard let filter = CIFilter(name: "CIAreaAverage",
                                parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
    guard let outputImage = filter.outputImage else { return nil }
    
    var bitmap = [UInt8](repeating: 0, count: 4)
    let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
    
    context.render(outputImage,
                   toBitmap: &bitmap,
                   rowBytes: 4,
                   bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                   format: .RGBA8,
                   colorSpace: nil)
    
    return UIColor(red: CGFloat(bitmap[0]) / 255,
                   green: CGFloat(bitmap[1]) / 255,
                   blue: CGFloat(bitmap[2]) / 255,
                   alpha: CGFloat(bitmap[3]) / 255)
  }
  
  func resizeTopAlignedToFill(newWidth: CGFloat) -> UIImage? {
    let newHeight = size.height * newWidth / size.width
    
    let newSize = CGSize(width: newWidth, height: newHeight)
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
    draw(in: CGRect(origin: .zero, size: newSize))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
}
