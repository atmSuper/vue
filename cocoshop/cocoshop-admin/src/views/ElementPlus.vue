<template>
    <h1>ElementPlus.vue组件</h1>
    <el-button type="primary"> 点击</el-button>

    <el-button type="primary"> 点击</el-button>
</template>
<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
    setup() {},
    methods: {
        jump() {
            this.$router.push('/vuex')
        }
    }
})
</script>
