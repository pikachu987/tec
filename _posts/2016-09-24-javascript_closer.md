---
layout:     post
title:      javaScript closer
date:       2016-09-23 12:20:00
summary:    closer에 대해 기초적인 문법을 배워보자!
categories: javascript
---

closer란?

> 클로저는 독립적인 (자유) 변수를 가리키는 함수이다. 또는, 클로저 안에 정의된 함수는 만들어진 환경을 '기억한다'.
[https://developer.mozilla.org/ko/docs/Web/JavaScript/Guide/Closures](https://developer.mozilla.org/ko/docs/Web/JavaScript/Guide/Closures)

일단 우리가 기본적으로 쓰는 function 에 대해서 만들어보자

~~~~
function add(x, y){
 return x+y;
}

add(3, 4); //7
~~~~

이렇게 쓴다.

그러면 콜백함수에 대해서 알아보자.

~~~~
function callbackTest(callback){
 if(callback != undefined){
   callback();
 }
}

callbackTest(function(){
  console.log('callback success!');
});
~~~~

많이 사용하는 문법이다. 예를 들어 jQuery의 click같은..

~~~~
$('#btn_01').click(function(){
  //click
});
~~~~

그리고 함수를 리턴하는 방식도 있다.

~~~~

function returnFunc(a){
 return function(b){
   alert(a+b);
 }
}
returnFunc(3)(4); //7

var rf = returnFunc(3);
rf(5); //8

~~~~

그럼 이제 클로저로 들어가 보겠다.
클로저는 함수 내부에 지역변수가 있고 지역변수가 값을 기억하고 있는 것이다.

~~~~
function outerFunc(){
    var a= 0;
    return {
        innerFunc1 : function(){
            a+=1;
            console.log("a :"+a);
        },
        innerFunc2 : function(){
            a+=2;
            console.log("a :"+a);
        }
    };
}
var out = outerFunc();
out.innerFunc1();
out.innerFunc2();
out.innerFunc2();
out.innerFunc1();

//실행결과
/*
a = 1
a = 3
a = 5
a = 6
*/
~~~~


~~~~

function outerFunc(){
    var a= 0;
    return {
        innerFunc1 : function(){
            a+=1;
            console.log("a :"+a);
        },
        innerFunc2 : function(){
            a+=2;
            console.log("a :"+a);
        }
    };
}
var out = outerFunc();
var out2 = outerFunc();
out.innerFunc1();
out.innerFunc2();
out2.innerFunc1();
out2.innerFunc2();
//실행결과
/*
a = 1
a = 3
a = 1
a = 3
*/

~~~~

[예제 참고](http://www.nextree.co.kr/p7363/)


변수는 지역변수, 전역변수로 나뉘는데 지역변수는 함수안에서 선언해서 함수가 끝나면 지역변수도 사라지기 때문에 지역변수를 다시 호출할 수 없게 된다.
그런데 script에서는 사라진 지역변수를 사용할 수 있다.
이런 것을 클로저라고 부른다. 그리고 지금은 새벽 2시 30분이다. 너무 피곤하다.
