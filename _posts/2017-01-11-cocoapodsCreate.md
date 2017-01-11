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

cocoapods 란?

> ios(Objective-c, Swift)에서 모든(네트워크, 복잡한 애니메이션, 복잡한 이벤트 등등) 을 기간이 정해져 있는 프로젝트에서 다 만들기는 힘든 사항이다. 그래서 다른 갓(GOD) 님들이 미리 만들어주신 라이브러리를 간단히 쓸수 있다.(자바의 Maven같은?)
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

##### 하지만!!! 이 갓(GOD)분들이 만들어 주신거를 사용하다보니 내가 이런거를 만들고 싶다면?!

[https://guides.cocoapods.org/making/making-a-cocoapod.html](https://guides.cocoapods.org/making/making-a-cocoapod.html)

> 여기에 설명이 나와있지만... 나같은 핵몽총이는 이걸 보고 삽질을 많이 했었다......ㅜㅜ
> 내가 지금부터 쓸 예제는 코딩을 하다보면 이것저것 건지는 소스들이 많은데 유용한 것들을 클래스화 시켜서 매번 프로젝트 생성시 복붙(command c + command v) 를 하던 것들을 라이브러리화 시켜서 cocoapods로 관리하려는 예제임(물론 당연하게 내가 편하려고....)


터미널을 연다. 그리고 라이브러리 폴더를 내가 보기편한곳에 나두려면 터미널에서 해당 장소로간다.(나는 Desktop)
그리고 pod lib create [라이브러리네임] 을 친다.

> 나는 라이브러리 네임을 PKCUtil 로 하겠다. PKC가 pikachu의 약자라서 그런건 맞음.

<br><br>

![Alt text](/tec/images/ios_cocoapods/4.png)

<br><br>

그럼 이런 창이 나오게 된다.

그리고 언어를 물어보는데 나는 Swift라고 하겠다.
다음은 데모 앱을 만들겠냐고 하는건데 Yes를 입력하겠다.
그다음은 나는 None라고 하겠다.
그다음은 아몰랑 그냥 No....

> 어휴... 물어보는게 왜이리 많아

<br><br>

![Alt text](/tec/images/ios_cocoapods/5.png)

<br><br>

이후에 이렇게 된다.

<br><br>

![Alt text](/tec/images/ios_cocoapods/6.png)

<br><br>

그리고 프로젝트가 실행이 된다!!!(마이그레이션을 하라고 하는데 Convert를 사뿐히 눌러주자! 안나올수도 있음)

<Br><br><br>

![Alt text](/tec/images/ios_cocoapods/7.png)

프로젝트구조가 이런식으로 되어있다.(옵젝씨는 다를수있음 물론 옵젝님들은 고수니까 충분히 알아볼수있으실듯....)

<br><br><br>

### 1. PKCUtil.podspec를 보겠다.

![Alt text](/tec/images/ios_cocoapods/8.png)

;;;;;;;;;;당황
일단 #은 주석임

고칠꺼는 s.summary 과 s.description 깃허브 아이디들


![Alt text](/tec/images/ios_cocoapods/9.png)

무슨 해리포터가 마법을 쓰는거처럼 간단간단해졌네용 +_+!!!!!!
영어는 당연 구글 번역!!!!
주석은 다 delete !!!(안지워도 됨)

<br><br>

### 2. README.md를 보겠다.

이건 깃허브에 다른사람들이 볼 마크다운 파일이다.
물론 엄청엄청 대단대단 갓갓 님들이 엄청엄청 대단한 라이브러리를 만들어서 사람들에게 쓰게 하려면 마크다운을 보고 다른 사람들이 쉽게 쓸수 있도록 이쁘게 쓰면 된다.(난 패스!)

<br><br>

### 3. ViewController.swift를 보겠다.

여기는 내가 만든 라이브러리들을 Example로 코딩 할 수 있다.
사용자들은 마크다운을 보고 이해가 가지 않으면 프로젝트를 다운받아서 뷰컨.swift를 보고 이해할 꺼니까!!! Main.storyboard를 써도 된다. 당연히 뷰컨이랑 연결되어 있다.

(
내가 라이브러리 만든거는 당연 여기서도 import를 해줘야함

~~~~
import PKCUtil
~~~~

)

<br><br>

### 4. Pods/Development Pods/PKCUtil(podName)/PKCUtil(podName)/Classes 를 보겠다.

> 휴.... 이제 대망의 라이브러리 만들기! (는;; 생각보다 간단하다. 이후 터미널작업이 귀찬;;)

ReplaceMe.swift라고 친절히 나를 바꾸세요 라는 클래스가 있다.
여기에 클래스를 막 둔다

> 고수님들꺼 보면 fileprivate, protocol, open, lazy, class func, @objc 등등 어려운 코드들이 막 있다. ㅜ
> 여기서 open을 쓰게 되면 외부 (프로젝트를 만들어서 cocoapods install한 프로젝트) 에서 method나 변수에 접근 가능하게 된다.

이 클래스에 내가 라이브러리화 시킬걸 넣자. xib, storyboard, class 막막 다 넣을수있따!

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

이렇게 하는이유가 깃이랑 pod랑 연동되어야 하기 때문에 깃과 연동되있는 폴더에 pod create한 파일들을 옮기는 작업이다.(나는 몽총이라서 이런 노가다를 한다 ㅜㅜ)

<br><br><br>

## 이제 터미널!

터미널에서 만든 폴더(나는 데스크탑에 PKCUtil를 만들었으니까 /Users/guanho/Desktop/PKCUtil)에 cd로 들어간다.
그리고 터미널에서

~~~~
pod lib lint
~~~~

를 써준다.

![Alt text](/tec/images/ios_cocoapods/10.png)

> cocoapods, 로맨틱, 성공적

<br><br><br>

만약에 에러가 나면

![Alt text](/tec/images/ios_cocoapods/11.png)


이런식으로 난다.
당황하지말고;;;;;

어떤 에러인지 찾아보자

![Alt text](/tec/images/ios_cocoapods/12.png)

~~~~
pod lib lint --allow-warnings PKCUtil.podspec
~~~~

그대로 복사하지 말고 PKCUtil를 podName으로 바꿔주자;;;;


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

이제 깃에는 올렸다!!!!

<br><br>

### 이제 cocoapods 올려야함

터미널에서

~~~~
pod trunk push PKCUtil.podspec
~~~~

를 해주자!(PKCUtil 에는 podName을 당연히 써주고...)

<Br><Br>


## 두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구두구

<Br><Br>

![Alt text](/tec/images/ios_cocoapods/18.png)


짜잔!!!! 정상적으로 올라간게 보인다.
넘나 기분 좋은것

<br>

하지만 [cocoapods](https://guides.cocoapods.org/making/making-a-cocoapod.html) 여기에 바로 나오는건 아니고 좀 시간을 기다려야 나오게 된다.
하지만 프로젝트를 만든 후에
Profile 파일에

~~~~
pod "PKCUtil"
~~~~

을 쓰게 되면 바로 설치가 된당~~~ 후훗



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

그리고 마지막 cocoapods에 푸시!!!!

하면 끝난다.
버전 업데이트 또한 푸시하자마자 cocoapods에서 바로 버전바뀐게 보이지 않고 시간이 지나야 보이게 된다.
하지만 Profile에

~~~~
pod 'podName'
~~~~

을 적고

~~~~~
pod install
~~~~

을 하면 바로 수정이 된다.
