---
layout:     post
title:      swift Image Face Detector, Blur
date:       2018-12-02 08:00:00
summary:    Swift 이미지에 얼굴찾고 얼굴 모자이크처리, 이미지로 씌우기
categories: swift
---

<img src = "/tec/images/2018/12/faceDetector/blur.gif" width='200px'>


#### CIDetector를 사용하여 face를 찾기

```swift
private func faceDetector(_ image: UIImage?) {
    guard let image = image,
        let ciImage = CIImage(image: image),
        let ciDetector = CIDetector(
            ofType: CIDetectorTypeFace,
            context: nil,
            options: [CIDetectorAccuracy : CIDetectorAccuracyHigh]
        ) else { return nil }

    let features = ciDetector.features(in: ciImage)
    if features.isEmpty { return image }
    print(features);
}
```

#### 찾은 face에 blur 적용하기

```swift
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
```

![Alt Text](/tec/images/2018/12/faceDetector/blur.png)

#### 찾은 face에 이미지 적용하기

```swift
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
```

![Alt Text](/tec/images/2018/12/faceDetector/image.png)


[예제](/tec/images/2018/12/faceDetector/ViewController.swift)
