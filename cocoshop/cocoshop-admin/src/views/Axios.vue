<template>
    <h1>Axios.vue组件</h1>
</template>
<script lang="ts">
import { defineComponent } from 'vue'
import axios from '../utils/axios'

export default defineComponent({
    setup() {},
    mounted() {
        axios({
            url: '/abc',
            method: 'get'
        }).then(() => {})
    }
})
</script>
