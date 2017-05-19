---
layout:     post
title:      cocoapods lib create
date:       2017-01-11 10:00:00
summary:    ios cocoapods에서 라이브러리를 생성해보자! (cocoapods lib create)
categories: ios
---

<br><br>


#### 1. cocoapods 남들이 만들어주신걸 써보기

#### 2. 내가 라이브러리를 만들어서 cocoapods에 올려보자!

#### 3. cocoapods 올린걸 업데이트 하기

<br><br><br><br>

[https://cocoapods.org/](https://cocoapods.org/)

<br><br>

## 1. cocoapods 남들이 만들어주신걸 써보기

남들이 만들어주신걸 쓰기에는 엄청 편하다.
프로젝트를 생성해서 터미널로 해당 프로젝트가 있는 폴더에

~~~~
pod init
~~~~

이라고 하면 Podfile이라는 파일이 만들어진다.
해당 파일을 열어보면

![Alt text](/tec/images/ios_cocoapods/1.png)

이런식의 구조가 만들어져 있을 것이다.
그럼 use_frameworks! 밑에줄에 스페이스바두번 이후에 pod 'podName' 이런식으로 적으면 된다.

#### 예제!

![Alt text](/tec/images/ios_cocoapods/2.png)


이후에 저장하고 터미널로

~~~~
pod install
~~~~

이라고 하면 터미널에서 엄청 많은것들이 다운받아지고 폴더 구조가 바뀐다.
그리고 .xcworkspace 을 실행시키면 라이브러리들이 다운받아져 있는걸 볼수 있다!

![Alt text](/tec/images/ios_cocoapods/3.png)

<br><br><br><br>


## 2. 내가 라이브러리를 만들어서 cocoapods에 올려보자!


[https://guides.cocoapods.org/making/making-a-cocoapod.html](https://guides.cocoapods.org/making/making-a-cocoapod.html)


터미널을 연다. 그리고 라이브러리 폴더를 내가 보기편한곳에 나두려면 터미널에서 해당 장소로간다.(나는 Desktop)
그리고 pod lib create [라이브러리네임] 을 친다.


<br><br>

![Alt text](/tec/images/ios_cocoapods/4.png)

<br><br>

그럼 이런 창이 나오게 된다.

그리고 언어를 물어보는데 나는 Swift라고 하겠다.
다음은 데모 앱을 만들겠냐고 하는건데 Yes를 입력하겠다.
그다음은 None, No

<br><br>

![Alt text](/tec/images/ios_cocoapods/5.png)

<br><br>

이후에 이렇게 된다.

<br><br>

![Alt text](/tec/images/ios_cocoapods/6.png)

<br><br>

![Alt text](/tec/images/ios_cocoapods/7.png)

<br><br><br>

### PKCUtil.podspec를 보겠다.

![Alt text](/tec/images/ios_cocoapods/8.png)

일단 #은 주석임

고칠꺼는 s.summary 과 s.description 깃허브 아이디들


![Alt text](/tec/images/ios_cocoapods/9.png)

<br><br>

### Pods/Development Pods/PKCUtil(podName)/PKCUtil(podName)/Classes 를 보겠다.

ReplaceMe.swift라고 친절히 나를 바꾸세요 라는 클래스가 있다.

<br><br>

그리고 깃허브(https://github.com) 에서 리포지토리(repository)를 podName과 똑같이 하나 만들어 놓자!
그리고 해당 깃을(나는 https://github.com/pikachu987/PKCUtil.git) clone하자.
클론하는 방법은 터미널에서

~~~~
git clone https://github.com/pikachu987/PKCUtil.git
~~~~

라고 하면 터미널 pwd 위치에 클론이 된다.
clone한 폴더에 내가 만든 cocoapods 폴더 전체(command+A)를 넣자.

![Alt text](/tec/images/ios_cocoapods/14.png)

<br><br><br>

## 이제 터미널!

터미널에서 만든 폴더(나는 데스크탑에 PKCUtil를 만들었으니까 /Users/guanho/Desktop/PKCUtil)에 cd로 들어간다.
그리고 터미널에서

~~~~
pod lib lint
~~~~

를 써준다.

![Alt text](/tec/images/ios_cocoapods/10.png)


<br><br><br>

만약에 에러가 나면

![Alt text](/tec/images/ios_cocoapods/11.png)


이런식으로 난다.

어떤 에러인지 찾아보자

![Alt text](/tec/images/ios_cocoapods/12.png)

~~~~
pod lib lint --allow-warnings PKCUtil.podspec
~~~~

그대로 복사하지 말고 PKCUtil를 podName으로 바꿔주자.


![Alt text](/tec/images/ios_cocoapods/13.png)

그러면 어떤것들이 잘못됬는지 리스트로 보인다.  고친다음 다시 pod lib lint를 하자


<br><Br><br>

[cocoapods](https://guides.cocoapods.org/making/making-a-cocoapod.html) 에서는 이런식으로 설명이 되어있다.

~~~~
git add -A && git commit -m "커밋 메시지를 쓰세요~~~~"
git tag '0.1.0'
git push --tags
git push origin master
~~~~

git tag에는 PKCUtil.podspec파일의 s.version 과 같은 버전을 쓰면된다.

<br><br>

![Alt text](/tec/images/ios_cocoapods/15.png)

![Alt text](/tec/images/ios_cocoapods/16.png)

![Alt text](/tec/images/ios_cocoapods/17.png)

<br><br>

### 이제 cocoapods 올려야함

터미널에서

~~~~
pod trunk push PKCUtil.podspec
~~~~


<Br><Br>


<Br><Br>

![Alt text](/tec/images/ios_cocoapods/18.png)


<br>

하지만 [cocoapods](https://guides.cocoapods.org/making/making-a-cocoapod.html) 여기에 바로 나오는건 아니고 좀 시간을 기다려야 나오게 된다.
하지만 프로젝트를 만든 후에
Profile 파일에

~~~~
pod "PKCUtil"
~~~~

을 쓰게 되면 바로 설치가 된다

[cocoapods](https://guides.cocoapods.org/making/making-a-cocoapod.html) 에 정상적으로 올라와 있는 스크린샷이다.

![Alt text](/tec/images/ios_cocoapods/22.png)



<Br><Br><Br><Br>

## 3. cocoapods 올린걸 업데이트 하기

그리고 업데이트를 하려면 수정할 클래스파일 등등을 수정 후

![Alt text](/tec/images/ios_cocoapods/21.png)

podName.podspec 에 s.version 버전을 바꾼 후

![Alt text](/tec/images/ios_cocoapods/19.png)

![Alt text](/tec/images/ios_cocoapods/20.png)

여기 여기로 해서 버전을 같게 바꾸자.

그리고

~~~~
pod lib lint
~~~~

를 해서 에러검사를 하고

~~~~
git add -A && git commit -m "커밋 메시지를 쓰세요~~~~"
git tag '바꾼 버전'
git push --tags
git push origin master
~~~~

git tag에 버전을 같게 올린다.


~~~~
pod trunk push PKCUtil.podspec
~~~~

그리고 cocoapods에 푸시

하면 끝난다.
버전 업데이트 또한 푸시하자마자 cocoapods에서 바로 버전바뀐게 보이지 않고 시간이 지나야 보이게 된다.
하지만 Profile에

~~~~
pod 'podName'
~~~~

을 적고

~~~~
pod install
~~~~

을 하면 바로 수정이 된다.
