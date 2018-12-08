---
layout:     post
title:      swift @escaping @noescape
date:       2018-12-07 08:00:00
summary:    Swift @escaping @noescape 알아보기
categories: swift
---


함수에서 클로져를 쓸때

```Swift

func example(_ handler: (() -> Void)) {

}

func example(_ handler: ((Int) -> Int)) {

}

```

이런식으로 쓴다.
이렇게 함수에 클로져를 쓰다보면

![Alt Text](/tec/images/2018/12/escape/error.png)

이런식으로 에러가 나온다.
물론 에러를 누르고 fix를 하면 자동으로 클로져에 @escaping 가 붙는다.

escaping는 탈출한다는 뜻이고 클로져가 함수를 탈출할때 붙는다.
noescape는 함수를 탈출하지 않을때 사용되며 생략한다. 즉, 그냥 클로져를 사용하면 noescape로 된다.

클로져가 함수를 탈출하는 상황은 두가지가 있다.

1) 비동기 실행: 클로저가 비동기로 실행되면 클로저를 잡고 있어야한다.

2) 저장소: 클로저를 변수나 프로퍼티에 저장할때.

#### 비동기 실행

```Swift

func example(_ handler: @escaping (() -> Void)) {
    DispatchQueue.main.async {
        handler()
    }
}

```

함수종료 이후에 클로져가 실행되므로 클로져를 잡고 있어야 한다. @escaping 를 사용하여야 한다.

#### 저장소

```Swift

var handler: (() -> Void)?

func example(_ handler: @escaping (() -> Void)) {
    self.handler = handler
}

```

또는

```Swift

func example(_ handler: @escaping (() -> Void)) {
    var handlerTemp = handler

}

```

클로져가 변수에 저장하려면 @escaping 를 사용하여야 한다.
