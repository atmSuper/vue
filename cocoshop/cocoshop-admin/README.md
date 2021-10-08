1. 样式的绑定 
:root {
  --varColor: yellow;
}
.el {
   width: 20px;
   height: 20px;
   color: v-bind(color);
   font-size: v-bind(fontSize);
}
.atm {
  color: var(--varColor);
}
 const color = "red";
 const fontSize = "20px";

 2 watcht
  watch(()=>state.count,(count,preventCount)=>{
   console.log(count)
 },{
   deep:true,
   immediate:false
 })