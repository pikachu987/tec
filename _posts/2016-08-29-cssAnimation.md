---
layout:     post
title:      css animation
date:       2016-08-29 20:30:00
summary:    css 애니메이션에 대하여
categories: css
---

일단 애니메이션 예제들을 살펴보자.<br>
<a href="https://web-animations.github.io/web-animations-demos/" target="_blank">https://web-animations.github.io/web-animations-demos/</a>

<a href="/testFile/1/test.html" target="_blank">test1</a>

~~~~
animation-delay: 애니메이션이 언제 시작할지 ex)2s(2초후 시작)

animation-name: keyframes 이름

animation-duration: 한 싸이클의 애니메이션의 시간 ex)2s(2초동안)

animation-fill-mode: 애니메이션이 시작되기 전이나 끝나고 난 후 어떻게 적용될지 지정
* forwards; (마지막 키프레임에 지정된 값을 유지)
* backwards; (첫 번째 키프레임에 지정한 값으로 돌아감)

animation-timing-function: 중간 상태의 애니메이션을 어떻게 진행할지 지정
* ease; 시작과 종료를 부드럽게
* linear; 일정
* ease-in; 서서히 시작
* ease-out; 서서히 종료
* ease-in-out; 서서히 시작하여 서서히 종료
* cubic-bezier(1,.23,0,1.56); /* 배지어곡선 */

animation-iteration-count: 애니메이션이 몇반 반복될지 지정
* infinite; 무한반복

animation-direction: 애니메이션이 종료된 다음 어떤식으로 진행될지 지정
* nomal;(기본값, 애니메이션이 시작될 때마다 처음으로 설정됨)
* reverse;(반대로 진행)
* alternate;(순방향으로 진행한 후 역방향으로 진행)
* alternate-reverse;(역방향으로 진행한 후 순방향으로 진행)

animation-play-state: 애니메이션을 멈추가나 다시 시작
* running;
* paused;



@keyframes <name> {
  from{
  	margin-left: 0px;
  }

  to{
  	margin-left: 300px;
  }
}

@keyframes <name> {
  0% {
  	transform: rotate(0deg);
  }
  50% {
    transform: rotate(30deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

~~~~


<a href="/testFile/1/t_translate.html" target="_blank">translate</a><br>
<a href="/testFile/1/t_scale.html" target="_blank">scale</a><br>
<a href="/testFile/1/t_rotate.html" target="_blank">rotate</a><br>
<a href="/testFile/1/t_skew.html" target="_blank">skew</a><br>
<a href="/testFile/1/t_matrix.html" target="_blank">matrix</a>


~~~~
2D transform 메소드

translate(x, y) : 가로, 세로 방향으로 이동
- translateX(x)
- translateY(y)

scale(x, y) : 확대/축소 비율 지정
- scaleX(x)
- scaleY(y)

rotate(angle) : 객체를 회전시킴 (단위 - deg(degree))

skew(x-angle, y-angle) : 객체를 기울임 (단위 - deg)
- skewX(x-angle)
- skewY(y-angle)
/* 비표준 */

matrix(a, c, b, d, tx, ty) : 다 합침
/* a, b, c, d 로 transformation matrix 가 구성되며,
   ┌     ┐
   │ a b │
   │ c d │
   └     ┘
   tx, ty 는 이동되는 값이다.  */

c: scaleY
b: scaleX


~~~~
