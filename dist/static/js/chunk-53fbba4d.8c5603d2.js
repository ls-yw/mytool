(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-53fbba4d"],{"53f3":function(t,e,i){"use strict";i("9791")},9791:function(t,e,i){},d80c:function(t,e,i){"use strict";i.r(e);var m=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"container"},[i("div",{staticClass:"container-header"},[t._v(" 现在的时间戳是： "),i("el-input",{attrs:{readonly:""},model:{value:t.timeStamp,callback:function(e){t.timeStamp=e},expression:"timeStamp"}}),t.timeStampIntervalId?t._e():i("el-button",{attrs:{type:"primary",size:"medium"},on:{click:t.startTimeStamp}},[t._v("开始")]),t.timeStampIntervalId?i("el-button",{attrs:{type:"danger",size:"medium"},on:{click:t.stopTimeStamp}},[t._v("停止")]):t._e(),t.timeStampIntervalId?t._e():i("el-button",{attrs:{size:"medium"},on:{click:t.refreshTimeStamp}},[t._v("刷新")])],1),i("div",{staticClass:"timeConvert-item"},[i("div",[t._v("时间戳 → 北京时间")]),i("div",{staticClass:"input"},[i("el-input",{model:{value:t.timeTimestamp,callback:function(e){t.timeTimestamp=e},expression:"timeTimestamp"}})],1),i("div",[i("el-button",{attrs:{type:"primary",size:"medium"},on:{click:t.timeToBj}},[t._v("转换")])],1),i("div",{staticClass:"input"},[i("el-input",{model:{value:t.bjTimestamp,callback:function(e){t.bjTimestamp=e},expression:"bjTimestamp"}})],1)]),i("el-divider"),i("div",{staticClass:"timeConvert-item"},[i("div",[t._v("北京时间 ← 时间戳")]),i("div",{staticClass:"input"},[i("el-input",{model:{value:t.bjTime,callback:function(e){t.bjTime=e},expression:"bjTime"}})],1),i("div",[i("el-button",{attrs:{type:"primary",size:"medium"},on:{click:t.bjToTime}},[t._v("转换")])],1),i("div",{staticClass:"input"},[i("el-input",{model:{value:t.timeTime,callback:function(e){t.timeTime=e},expression:"timeTime"}})],1)])],1)},a=[],s={name:"timeConvert",data(){return{timeStamp:0,timeStampIntervalId:null,timeTimestamp:0,bjTimestamp:"",bjTime:"",timeTime:""}},mounted(){let t=new Date;this.timeTimestamp=(t.getTime()/1e3).toFixed(0),this.bjTime=this.formatDate(t),this.startTimeStamp()},methods:{getTimestamp(){this.timeStamp=((new Date).getTime()/1e3).toFixed(0)},startTimeStamp(){this.refreshTimeStamp(),this.timeStampIntervalId=setInterval(this.getTimestamp,1e3)},stopTimeStamp(){window.clearInterval(this.timeStampIntervalId),this.timeStampIntervalId=null},refreshTimeStamp(){this.timeStamp=((new Date).getTime()/1e3).toFixed(0)},formatDate(t){const e=t.getFullYear(),i=t.getMonth()+1,m=t.getDate();let a=t.getHours();a<10&&(a="0"+a);let s=t.getMinutes();s<10&&(s="0"+s);let n=t.getSeconds();return n<10&&(n="0"+n),e+"-"+i+"-"+m+" "+a+":"+s+":"+n},timeToBj(){if(13!==this.timeTimestamp.length&&10!==this.timeTimestamp.length)return this.$message.error("时间戳格式错误"),!1;const t=10===this.timeTimestamp.length?1e3*parseInt(this.timeTimestamp):this.timeTimestamp;this.bjTimestamp=this.formatDate(new Date(t))},bjToTime(){this.timeTime=Date.parse(new Date(this.bjTime))/1e3}}},n=s,l=(i("53f3"),i("2877")),r=Object(l["a"])(n,m,a,!1,null,"06f5f092",null);e["default"]=r.exports}}]);