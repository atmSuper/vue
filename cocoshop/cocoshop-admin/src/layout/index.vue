<template>
    <div class="app-wrapper">
        <sidebar class="sidebar-container" />
    </div>
</template>
<script lang="ts">
  import { defineComponent, reactive, ref, unref} from 'vue';
  import { Sidebar } from './components';
  export default defineComponent({
     name: 'Layout',
     setup(){
     },
     components:{
         Sidebar,
     }
  })
</script>
<style lang="scss">

</style>