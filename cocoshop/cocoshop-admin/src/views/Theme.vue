<template>
  <h1>主题.vue</h1>
  <div class="flex">
    <div class="box"></div>
  </div>
  <button @click="changeTheme">改变主题</button>
</template>
<style scoped lang="scss">
.box {
  width: 100px;
  height: 100px;
  @include bg_color($background-color-theme);
}
</style>
<script>
import { defineComponent } from 'vue';

export default defineComponent({
  methods: {
    changeTheme() {
      window.document.documentElement.setAttribute('data-theme', 'theme1');
    }
  }
});
</script>
