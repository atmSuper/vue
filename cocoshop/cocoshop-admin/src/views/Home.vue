<template>
  Home.vue组件

  <br />
  <button @click="jump">跳转Vuex页面</button>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  setup() {},
  methods: {
    jump() {
      this.$router.push('/vuex');
      console.log('Hello World!!!');
    }
  }
});
</script>
