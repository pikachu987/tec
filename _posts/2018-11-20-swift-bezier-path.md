---
layout:     post
title:      swift UIBezierPath Shape
date:       2018-11-20 08:00:00
summary:    Swift UIBezierPath로 여러가지 도형, 말풍선 그리기(Arrow, Triangle, Square, Pentagon, Star, Heart, Bubble, Chat, Message)
categories: swift
---

#### 1. 라인(Line)

```Swift

class Example: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.lightGray.setFill()
        path.fill()
        path.close()

        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: rect.height / 2))
        linePath.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        linePath.lineWidth = 6
        UIColor.black.set()
        linePath.stroke()
        linePath.close()
    }
}

```
