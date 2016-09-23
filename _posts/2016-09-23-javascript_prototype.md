---
layout:     post
title:      javaScript prototype
date:       2016-09-23 12:10:00
summary:    prototype에 대해 기초적인 문법을 배워보자!
categories: javascript
---

prototype란?

> 프로토타입(prototype)은 원래의 형태 또는 전형적인 예, 기초 또는 표준이다. 시제품이 나오기 전의 제품의 원형으로 개발검증과 양산 검증을 거쳐야 시제품이 될 수 있다. 프로토타입은 '정보시스템의 미완성 버전 또는 중요한 기능들이 포함되어 있는 시스템의 초기모델'이다. 이 프로토타입은 사용자의 모든 요구사항이 정확하게 반영할 때까지 계속해서 개선/보완 된다. 실제로 많은 애플리케이션들이 지속적인 프로토타입의 확장과 보강을 통해 최종 설계가 승인된다.
프로토타입이라는 낱말은 원초적 형태라는 뜻의 그리스어 낱말 πρωτότυπον (프로토타이폰)에서 왔다. 이는 원초적이라는 뜻의 πρωτότυπος (프로토타이포스)의 중간음에서 온 것으로, 더 들어가서 "최초의"라는 뜻의 πρῶτος(프로토스)와 "인상"이라는 뜻의 τύπος(타이포스)에서 비롯된 것이다.[1]
[https://ko.wikipedia.org/wiki/프로토타입](https://ko.wikipedia.org/wiki/프로토타입)

라고 설명되어 있는데 간단히 설명하자면 객체의 모태가되는 형태(Arrays, String, Number ...)를 프로토타입이라고 한다.

~~~~
<script>
  var text = new String();
  console.log(text);
</script>
~~~~

간단하게 이러한 코드를 작성하고 크롬 console로 열어보면

![Alt text](/tec/images/script_prototype/1.png)


여기서 `__proto__` 가 해당 객체를 만들어내기 위해 사용된 객체 원형에 대해 숨겨진 연결이라고 한다.

스크립트의 객체는 생성과 동시에 Prototype Object라는 새로운 객체를 clone하여 만든다.
프로토타입이 객체를 만들어내기 위한 원형이면 Prototype Object 는 자신을 원형으로 만들어질 다른 객체가 참조할 프로토타입이 된다.
위에서 `__proto__` 라는 prototype 에 대한 link는 상위에서 물려받은 객체의 프로토타입에 대한 정보이다.


~~~~

<script>
var A = function () { };
A.prototype.x = function () {
    console.log('prototype');
};

A.x();
//Uncaught TypeError: A.x is not a function

var B = new A();
B.x();
//prototype
</script>

~~~~

A는 아직 객체로 만들어지지 않은 원형인 상태이고 B는 A를 물려받은 객체이다. 그래서 저런 결과가 나오게 된다.

~~~~

B.prototype.y = function(){
  console.log('prototype2');
}

~~~~

만약 위의 코드에 이코드를 추가하면 어떻게 될까?
정답은 Uncaught TypeError: Cannot set property 'y' of undefined 이런 에러가 나게 된다.
아까 말했듯이 객체 원형에 대해 숨겨진 연결이라고 했는데 이미 B는 객체 원형이 아니라 prototype를 쓸 수 없게 된다.

~~~~
console.log(B);
~~~~
B를 console.log로 찍어 보면

![Alt text](/tec/images/script_prototype/2.png)

`__proto__` 안에 x라는 function이 있다. 그래서 B에서는 x라는 프로토타입을 쓸 수 있게 된다.

__화살표를 계속 누르지 말자... 스크립트란놈은 양파같은 놈이라서 까도까도 계속 나온다.__

<br/><br/><br/>

### 그렇다면 이걸 어떻게 활용을 할까???

~~~~
String.prototype.width = function(font) {
	var f = font || '10px arial', o = $('<div>'+this+'</div>').css({'position': 'absolute', 'float': 'left', 'white-space': 'nowrap', 'visibility': 'hidden', 'font': f}).appendTo($('body')),w = o.width();
	o.remove();
	return w;
};
~~~~

해당 String에 대해 font를 적용한 실제 길이를 리턴하게 된다.

~~~~

<div>Hello</div>
$('#')
var str = 'Hello';
console.log(str.width());

~~~~

이 width를 활용하는 간단한 예제를 보겠다.


![Alt text](/tec/images/script_prototype/3.png)

~~~~

<style>
  .widthTest>div{
    display: inline-block; float: left; width: 240px; background-color: #efefef;
    border-radius: 10px; padding-left: 5px; padding-right: 5px;
    height: 100px; line-height: 100px; vertical-align: middle;
  }
  .widthTest>div:last-child{margin-left: 20px;}
</style>
<div class="widthTest">
  <div>동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세</div>
  <div>가나다라마바사</div>
</div>
<script>
String.prototype.width = function(font) {
  var f = font || '10px arial', o = $('<div>'+this+'</div>').css({'position': 'absolute', 'float': 'left', 'white-space': 'nowrap', 'visibility': 'hidden', 'font': f}).appendTo($('body')),w = o.width();
  o.remove();
  return w;
};



$('.widthTest>div').each(function(){


  var $this = $(this);
  if($this.width() < $this.text().width($this.css('font'))){
    $this.css('line-height', Number($this.css('line-height').replace('px',''))/2+'px');












    // var lineHeight = $this.css('line-height');
    // var lineHeightReplace = lineHeight.replace('px','');
    // $this.css('line-height', Number(lineHeightReplace/2)+'px');
  }



});




</script>

~~~~



![Alt text](/tec/images/script_prototype/4.png)



이것 말고도

~~~~
Array.prototype.remove = function(idx){
	var temp = [];
	var i = this.length;
	while(i > idx){
		var kk = this.pop();
		temp.push(kk);
		i--;
	}
	for(var j=temp.length - 2; j>=0; j--){
		this.push(temp[j]);
	}
};
String.prototype.replaceAll = function(find,replace){
	if(this === null || this === '') return '';
	return this.replace( new RegExp( find, 'g' ), replace );
};
String.prototype.setPriceComma = function() {
	var n = this;
	n += '';
	var reg = /(^[+-]?\d+)(\d{3})/;
	while (reg.test(n)){n = n.replace(reg, '$1' + ',' + '$2');}
	return n;
};
~~~~


여러가지가 있고 여러가지를 만들수 있다.
