(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-07186bb0"],{"9c23":function(e,t,a){"use strict";a.r(t);var r=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"container"},[a("div",{staticClass:"search-box"},[a("el-form",{staticClass:"demo-form-inline",attrs:{inline:!0,model:e.searchObj}},[a("el-form-item",{attrs:{label:"出发地"}},[a("el-cascader",{attrs:{options:e.regions,"show-all-levels":!1,placeholder:"请选择出发地",props:{value:"code",label:"name"},filterable:"",clearable:""},model:{value:e.searchObj.from,callback:function(t){e.$set(e.searchObj,"from",t)},expression:"searchObj.from"}})],1),a("el-form-item",{attrs:{label:"目的地"}},[a("el-cascader",{attrs:{options:e.regions,"show-all-levels":!1,props:{multiple:!0,checkStrictly:!0,value:"code",label:"name"},placeholder:"请选择目的地",filterable:"",clearable:""},model:{value:e.searchObj.to,callback:function(t){e.$set(e.searchObj,"to",t)},expression:"searchObj.to"}})],1),a("el-form-item",{attrs:{label:"查询天数"}},[a("el-select",{attrs:{placeholder:"请选择"},model:{value:e.searchObj.day,callback:function(t){e.$set(e.searchObj,"day",t)},expression:"searchObj.day"}},e._l(e.options,(function(e){return a("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})})),1)],1),a("el-form-item",[a("el-button",{attrs:{type:"primary"},on:{click:e.onSubmit}},[e._v("查询")])],1),a("el-form-item",[a("el-link",{attrs:{type:"success"},on:{click:e.changeShowType}},[e._v(e._s(1===e.showType?"表格":"图标"))])],1)],1)],1),a("div",{directives:[{name:"show",rawName:"v-show",value:1===e.showType,expression:"showType === 1"}],staticClass:"echarts-box"},[a("el-row",e._l(e.echartsIdArr,(function(e){return a("el-col",{key:e,attrs:{xs:24,sm:24,md:24,lg:12,xl:8}},[a("div",{staticClass:"echart-price",attrs:{id:"echarts-"+e}})])})),1)],1),a("div",{directives:[{name:"show",rawName:"v-show",value:1!==e.showType,expression:"showType !== 1"}],staticClass:"table-box"},[a("el-table",{staticStyle:{width:"100%"},attrs:{data:e.tableData}},[a("el-table-column",{attrs:{type:"index",width:"50"}}),a("el-table-column",{attrs:{prop:"name",label:"行程",fixed:"",sortable:"",width:"120"}}),e._l(e.xAxisData,(function(t,r){return a("el-table-column",{attrs:{label:t,sortable:"",width:"80"},scopedSlots:e._u([{key:"default",fn:function(t){return[e._v(" "+e._s(t.row[r].price)+" ")]}}],null,!0)})}))],2)],1)])},s=[],o=a("bc3a"),i=a.n(o);function n(e,t){const a=[];let r=new Date(e);while(r<=new Date(t)){const e=(r.getMonth()+1).toString().padStart(2,"0"),t=r.getDate().toString().padStart(2,"0");a.push(`${e}-${t}`),r.setDate(r.getDate()+1)}return a}a("6821");var l=a("d399");const c=i.a.create({baseURL:"https://fapi.woodlsy.com",timeout:5e3});c.interceptors.request.use(e=>{e.data,e.params;return e},e=>(console.log(e),Promise.reject(e))),c.interceptors.response.use(e=>{const t=e.data;return 0!==t.code?(l["a"].fail(t.msg||"Error"),101===t.code&&l["a"].fail("您未登录或登录信息已失效，请重新登录"),Promise.reject(new Error(t.msg||"Error"))):t},e=>(console.log("err"+e),l["a"].fail(e.msg),Promise.reject(e)));var h=c;const d=()=>h({method:"get",url:"/mytool/planeRegion"}),p=e=>h({method:"post",url:"/mytool/planeRegionBySearch",data:e}),m=i.a.create({timeout:5e3});m.interceptors.request.use(e=>{e.data,e.params;return e},e=>(console.log(e),Promise.reject(e))),m.interceptors.response.use(e=>e.data,e=>Promise.reject(e));var u=m;const b=(e,t)=>u({method:"post",url:e,data:t});var g={name:"plane",data(){return{searchObj:{from:[],to:[],day:30},options:[{value:30,label:"一个月"},{value:0,label:"不限"}],regions:[],departure:{},destination:[],url:"https://sec-m.ctrip.com/restapi/soa2/13516/lowPriceCalendar",echartsIdArr:[],tableData:[],showType:1,xAxisData:[]}},mounted(){this.getRegion()},methods:{getRegion(){d().then(e=>{if(this.regions=[],0===e.data.length)return!1;this.regions=this.transformRegionsData(e.data)})},transformRegionsData(e){let t=[];for(let a in e){let r=e[a],s={code:r.code,name:r.name,planeCode:r.planeCode,children:[]};Object.keys(r.children).length>0&&(s.children=this.transformRegionsData(r.children)),(""!==r.planeCode||s.children.length>0)&&(0===s.children.length&&delete s.children,t.push(s))}return t},initData(){this.echartsIdArr=[],this.xAxisData=[],this.tableData=[]},onSubmit(){if(0===this.searchObj.from.length)return void this.$message.error("请选择出发地");let e=[],t=[];this.searchObj.from.forEach(t=>{Array.isArray(t)?e.push(t[t.length-1]):(console.log("ele",t),e.push(t))}),this.searchObj.to.forEach(e=>{Array.isArray(e)?t.push(e[e.length-1]):t.push(e)}),this.initData(),p({from:e,to:t}).then(e=>{0!==e.data.from.length?(this.departure=e.data.from[0],this.destination=e.data.to,this.getPlanePrices()):this.$message.error("获取不到出发地信息")})},getPlanePrices(){const e=this;let t=0;const a=()=>{if(t<this.destination.length){const r=this.destination[t];e.echartsIdArr.push(r.code),e.chartsPlanePrice(r),setTimeout(()=>{t++,a()},2e3)}};a()},async chartsPlanePrice(e){let t={head:{},stype:1,dcty:this.departure.planeCode.toUpperCase(),acty:e.planeCode.toUpperCase(),start:"",end:"",flag:1};const a=this,r=await b(this.url,t);if(!r.prices)return this.$notify.error({message:this.departure.name+" - "+e.name+"接口返回解析失败",duration:0}),void console.log("toResult",r);t.dcty=t.acty,t.acty=a.departure.planeCode.toUpperCase();const s=await b(a.url,t);if(!s.prices)return this.$notify.error({message:e.name+" - "+this.departure.name+"接口返回解析失败",duration:0}),void console.log("backResult",s);a.drawingCharts(e,r.prices,s.prices)},drawingCharts(e,t,a){t.name=this.departure.name+"-"+e.name,a.name=e.name+"-"+this.departure.name,this.tableData.push(t),this.tableData.push(a);let r,s=document.getElementById("echarts-"+e.code),o=this.$echarts.init(s);this.xAxisData=30===this.searchObj.day?n(t[0].dDate,new Date(t[0].dDate).setDate(new Date(t[0].dDate).getDate()+30)):n(t[0].dDate,t[t.length-1].dDate),r={tooltip:{trigger:"axis"},legend:{data:[this.departure.name+"-"+e.name,e.name+"-"+this.departure.name]},xAxis:{type:"category",boundaryGap:!1,data:this.xAxisData},yAxis:{type:"value",axisLabel:{formatter:"{value}"}},series:[{name:this.departure.name+"-"+e.name,type:"line",data:t.map(e=>0===e.price?"-":e.price).slice(0,this.xAxisData.length),markPoint:{data:[{type:"max",name:"Max"},{type:"min",name:"Min"}]},itemStyle:{color:"#378BFF"}},{name:e.name+"-"+this.departure.name,type:"line",data:a.map(e=>0===e.price?"-":e.price).slice(0,this.xAxisData.length),markPoint:{data:[{type:"max",name:"Max"},{type:"min",name:"Min"}]},itemStyle:{color:"#008000"}}]},o.setOption(r)},changeShowType(){this.showType=1===this.showType?2:1}}},f=g,y=(a("b9bd"),a("2877")),w=Object(y["a"])(f,r,s,!1,null,"3d7660c3",null);t["default"]=w.exports},b70f:function(e,t,a){},b9bd:function(e,t,a){"use strict";a("b70f")}}]);