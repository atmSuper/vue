import { useStore } from '/@/vux';
import { computed, watch } from 'vue'
const store = useStore()
export default function(){
    const sidebar = computed(() => {
        return store.state.app.sidebar
    })
    return {
        sidebar
    }
}