(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-a05e76b4"],{"4c21":function(t,n,e){},bb99:function(t,n,e){"use strict";e.r(n);var s=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"container"},[e("div",{staticClass:"info"},[e("strong",[t._v(t._s(t.stringLength))]),t._v("个字符串，"),e("strong",[t._v(t._s(t.chineseLength))]),t._v("个中文字")]),e("div",{staticClass:"content"},[e("el-input",{attrs:{type:"textarea",rows:"10",placeholder:"输入字符串统计长度"},on:{input:t.computeLength},model:{value:t.content,callback:function(n){t.content=n},expression:"content"}})],1)])},c=[],i={name:"length",data(){return{content:"",stringLength:0,chineseLength:0}},methods:{computeLength(){this.stringLength=this.content.length;const t=this.content.match(/[\u4e00-\u9fff]/g);this.chineseLength=t?t.length:0}}},o=i,a=(e("c257"),e("2877")),h=Object(a["a"])(o,s,c,!1,null,"5973e6d4",null);n["default"]=h.exports},c257:function(t,n,e){"use strict";e("4c21")}}]);