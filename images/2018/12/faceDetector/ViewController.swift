//
//  ViewController.swift
//  Abcde
//
//  Created by Gwanho Kim on 03/12/2018.
//  Copyright © 2018 Gwanho Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var blurImageView: UIImageView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.blueAction(_:)))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.addImageAction(_:)))
    }
    
    @objc private func blueAction(_ sender: UIBarButtonItem) {
        self.activityIndicatorView.startAnimating()
        DispatchQueue.global().async {
            let image = self.blur(UIImage(named: "image.png"))
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.blurImageView.image = image
            }
        }
    }
    
    @objc private func addImageAction(_ sender: UIBarButtonItem) {
        self.activityIndicatorView.startAnimating()
        DispatchQueue.global().async {
            let image = self.imageAdd(UIImage(named: "image.png"))
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.blurImageView.image = image
            }
        }
    }
    
    private func blur(_ image: UIImage?) -> UIImage? {
        guard let image = image,
            let ciImage = CIImage(image: image),
            let ciDetector = CIDetector(
                ofType: CIDetectorTypeFace,
                context: nil,
                options: [CIDetectorAccuracy : CIDetectorAccuracyHigh]
            ) else { return nil }
        
        let features = ciDetector.features(in: ciImage)
        if features.isEmpty { return image }
        
        guard let pixelateFiler = CIFilter(name: "CIPixellate"),
            let composite = CIFilter(name: "CIBlendWithMask") else { return image }
        
        pixelateFiler.setValue(ciImage, forKey: kCIInputImageKey)
        pixelateFiler.setValue(max(ciImage.extent.width, ciImage.extent.height) / 60.0, forKey: kCIInputScaleKey)
        
        var maskImage: CIImage?
        
        features.forEach({ (feature) in
            let centerX = feature.bounds.origin.x + feature.bounds.size.width / 2.0
            let centerY = feature.bounds.origin.y + feature.bounds.size.height / 2.0
            let radius = min(feature.bounds.size.width, feature.bounds.size.height) / 1.5
            
            let radialGradient = CIFilter(name: "CIRadialGradient")
            radialGradient?.setValue(radius, forKey: "inputRadius0")
            radialGradient?.setValue(radius + 1, forKey: "inputRadius1")
            radialGradient?.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 1), forKey: "inputColor0")
            radialGradient?.setValue(CIColor(red: 0, green: 0, blue: 0, alpha: 0), forKey: "inputColor1")
            radialGradient?.setValue(CIVector(x: centerX, y: centerY), forKey: kCIInputCenterKey)
            
            let circleImage = radialGradient?.outputImage?.cropped(to: ciImage.extent)
            
            if maskImage == nil {
                maskImage = circleImage
            } else {
                let filter =  CIFilter(name: "CISourceOverCompositing")
                filter?.setValue(circleImage, forKey: kCIInputImageKey)
                filter?.setValue(maskImage, forKey: kCIInputBackgroundImageKey)
                maskImage = filter?.outputImage
            }
        })
        
        composite.setValue(pixelateFiler.outputImage, forKey: kCIInputImageKey)
        composite.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        composite.setValue(maskImage, forKey: kCIInputMaskImageKey)
        
        let context = CIContext(options: nil)
        guard let outputImage = composite.outputImage,
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return image }
        
        return UIImage(cgImage: cgImage, scale: 1, orientation: image.imageOrientation)
    }

    
    private func imageAdd(_ image: UIImage?) -> UIImage? {
        guard let image = image,
            let ciImage = CIImage(image: image),
            let ciDetector = CIDetector(
                ofType: CIDetectorTypeFace,
                context: nil,
                options: [CIDetectorAccuracy : CIDetectorAccuracyHigh]
            ) else { return nil }
        
        let features = ciDetector.features(in: ciImage)
        if features.isEmpty { return image }
        
        UIGraphicsBeginImageContextWithOptions(image.size, true, 0)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        features.forEach {  (feature) in
            var rect = CGRect()
            let originalMaxSize = max(feature.bounds.width, feature.bounds.height)
            let maxSize = originalMaxSize * 1.5
            
            rect.origin.x = feature.bounds.origin.x - (maxSize - originalMaxSize)/2
            rect.origin.y = image.size.height - (feature.bounds.height + feature.bounds.origin.y) - (maxSize - originalMaxSize)/2 - (maxSize - originalMaxSize)/8
            rect.size.width = maxSize
            rect.size.height = maxSize
            
            UIImage(named: "2.png")?.draw(in: rect)
        }
        let imageValue = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageValue
    }
}


