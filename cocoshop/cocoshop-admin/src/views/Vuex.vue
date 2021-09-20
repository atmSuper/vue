<template>
  <h1>Vuex.vue组件</h1>
  <p>state：{{ count }}</p>
  <p>getters：{{ double }}</p>
  <button @click="increment">actions：</button>
</template>
<script lang="ts">
import { defineComponent } from 'vue';
import { mapState, mapGetters, mapActions } from 'vuex';

export default defineComponent({
  setup() {},
  computed: {
    ...mapState({
      count: (state: any) => state.count
    }),
    ...mapGetters({
      double: 'double'
    })
  },
  methods: {
    ...mapActions(['increment'])
  },
  mounted() {}
});
</script>
