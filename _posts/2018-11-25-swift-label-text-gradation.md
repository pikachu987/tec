---
layout:     post
title:      swift UILabel Text Gradation
date:       2018-11-25 08:00:00
summary:    Swift UILabel의 텍스트에 Gradation 추가하기
categories: swift
---

[예제](https://github.com/pikachu987/TextGradation)

![Alt Text](/tec/images/2018/11/textGradation/text.png)

```Swift

func makeLabel() -> UILabel? {
    let label = UILabel()
    label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
    label.text = "Hello World!"

    let textSize = (label.text ?? "").size(withAttributes: [NSAttributedString.Key.font : label.font])

    let tempLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: textSize.width, height: .greatestFiniteMagnitude))
    tempLabel.numberOfLines = 0
    tempLabel.text = label.text
    tempLabel.font = label.font
    tempLabel.sizeToFit()
    let height = tempLabel.frame.height

    guard let image = self.image(CGSize(width: tempLabel.frame.width, height: height)) else { return nil }

    label.textColor = UIColor(patternImage: image)

    return label
}

func image(_ size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContext(size)
    defer { UIGraphicsEndImageContext() }
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    UIGraphicsPushContext(context)

    guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [UIColor.red.cgColor, UIColor.black.cgColor] as CFArray, locations: nil) else { return nil }
    context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: size.height), end: CGPoint(x: size.width, y: size.height), options: [])

    UIGraphicsPopContext()
    return UIGraphicsGetImageFromCurrentImageContext()
}

```
