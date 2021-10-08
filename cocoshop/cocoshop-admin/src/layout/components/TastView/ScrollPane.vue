<template>
  <el-scrollbar 
   ref="scrollContainerRef" 
   :vertical="false" 
   class="scroll-container"
   @wheel.prevent="handleScroll"
   >
    <slot />
  </el-scrollbar>
</template>

<script lang='ts'>
// 获取当前组件实例
// const instance = getCurrentInstance();
// 获取当前组件的上下文，下面两种方式都能获取到组件的上下文。
// const { ctx }  = getCurrentInstance();  //  方式一，这种方式只能在开发环境下使用，生产环境下的ctx将访问不到
// const { proxy }  = getCurrentInstance();  //  方式二，此方法在开发环境以及生产环境下都能放到组件上下文对象（推荐）
// ctx 中包含了组件中由ref和reactive创建的响应式数据对象,以及以下对象及方法;
import { defineComponent, ref, reactive, toRefs, onMounted, computed, getCurrentInstance, onBeforeUnmount} from 'vue'
import { ElScrollbar } from 'element-plus';
export default defineComponent({
  name: 'ScrollPane',
  emits:['scroll'],
  components:  {
      ElScrollbar
  },
  setup(_,context) {
    // wheel.prevent 鼠标滚动
    const scrollContainerRef = ref(null);
    const scrollWrapper = computed(()=>{
      return (scrollContainerRef.value as any).$refs.wrap as HTMLElement
    })
    
    const { ctx } = getCurrentInstance() as any;
    const tagSpacing = 4

    const state = reactive({
       handleScroll:(e: WheelEvent) => {
         const eventDelta = (e as any).wheelDelta || -e.deltaY * 40
          scrollWrapper.value.scrollLeft = scrollWrapper.value.scrollLeft + eventDelta / 4
       },
       moveToCurrentTag: (currentTag: HTMLElement) => {
        const container = (scrollContainerRef.value as any).$el as HTMLElement
        const containerWidth = container.offsetWidth
        const tagList = ctx.$parent.$refs.tag as any[]
        let fristTag = null
        let lastTag = null

        // find first tag and last tag
        if (tagList.length > 0) {
          fristTag = tagList[0]
          lastTag = tagList[tagList.length - 1]
        }

        if (fristTag === currentTag) {
          scrollWrapper.value.scrollLeft = 0
        } else if (lastTag === currentTag) {
          scrollWrapper.value.scrollLeft = scrollWrapper.value.scrollWidth - containerWidth
        } else {
          // find preTag and nextTag
          const currentIndex = tagList.findIndex(item => item === currentTag)
          const prevTag = tagList[currentIndex - 1]
          const nextTag = tagList[currentIndex + 1]
          // the tag's offsetLeft after of nextTag
          const afterNextTagOffsetLeft = nextTag.$el.offsetLeft + nextTag.$el.offsetWidth + tagSpacing
          // the tag's offsetLeft before of prevTag
          const beforePrevTagOffsetLeft = prevTag.$el.offsetLeft - tagSpacing

          if (afterNextTagOffsetLeft > scrollWrapper.value.scrollLeft + containerWidth) {
            scrollWrapper.value.scrollLeft = afterNextTagOffsetLeft - containerWidth
          } else if (beforePrevTagOffsetLeft < scrollWrapper.value.scrollLeft) {
            scrollWrapper.value.scrollLeft = beforePrevTagOffsetLeft
          }
        }
      }
    })
    const emitScroll = () =>{
      context.emit('scroll')
    }
    onMounted (()=>{
      scrollWrapper.value.addEventListener('scroll', emitScroll, true);
    })
    onBeforeUnmount(() => {
       scrollWrapper.value.removeEventListener('scroll', emitScroll)
    })
    return { 
       scrollContainerRef,
        ...toRefs(state)
      };
  },
})

</script>
<style lang="scss" scoped>

.scroll-container {
  .el-scrollbar__bar {
    bottom: 0px;
  }

  .el-scrollbar__wrap {
    height: 49px;
  }
}
</style>

<style lang="scss" scoped>
.scroll-container {
  white-space: nowrap;
  position: relative;
  overflow: hidden;
  width: 100%;
}
</style>