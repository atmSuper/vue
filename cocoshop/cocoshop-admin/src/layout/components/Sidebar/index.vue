<template>
  <el-scrollbar height="400px">
    <p v-for="item in 20" :key="item" class="scrollbar-demo-item">{{ item }}</p>
  </el-scrollbar>
</template>
<script lang="ts">
  import { defineComponent, reactive, ref, unref} from 'vue';
  import {  ElScrollbar} from 'element-plus'
  export default defineComponent({
     name: 'Layout',
     setup(){
         console.log('222')
     },
     components:{
         ElScrollbar
     }
  })
</script>

<style>

</style>