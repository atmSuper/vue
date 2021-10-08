<template>
  <div id="tags-view-container" class="tags-view-container">
    <scroll-pane  ref="scrollPaneRef"
      class="tags-view-wrapper" @scroll="handleScroll">
       <router-link
        v-for="tag in visitedViews"
        ref="tag"
        :key="tag.path"
        :class="isActive(tag) ? 'active' : ''"
        :to="{path: tag.path, query: tag.query, fullPath: tag.fullPath}"
        tag="span"
        @click.middle="!isAffix(tag)?closeSelectedTag(tag):''"
        @contextmenu.prevent="openMenu(tag, $event)"
        class="tags-view-item"
      >
        {{ t('route.' + tag.meta.title) }}
        <span
          v-if="!isAffix(tag)"
          class="el-icon-close"
          @click.prevent.stop="closeSelectedTag(tag)"
        />
      </router-link>
    </scroll-pane>
    <ul
      v-show="visible"
      :style="{left: left+'px', top: top+'px'}"
      class="contextmenu"
    >
      <li @click="refreshSelectedTag(selectedTag)">
        {{ t('tagsView.refresh') }}
      </li>
      <li
        v-if="!isAffix(selectedTag)"
        @click="closeSelectedTag(selectedTag)"
      >
        {{
          t('tagsView.close') }}
      </li>
      <li @click="closeOthersTags">
        {{ t('tagsView.closeOthers') }}
      </li>
      <li @click="closeAllTags(selectedTag)">
        {{ t('tagsView.closeAll') }}
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive, ref, watch, computed, onBeforeMount, toRefs, getCurrentInstance, nextTick} from 'vue';
import ScrollPane from './ScrollPane.vue';
import { useStore } from '/@/vux';
import { useI18n } from "/@/hook/web/useI18n";
import { TagView } from '/@/vux/modules/tagsview/state';
import { RouteRecordRaw, useRoute, useRouter } from 'vue-router'
import { TagsActionTypes } from '/@/vux/modules/tagsview/action-types';
export default defineComponent({
  name: 'TastView',
  setup() {
    // 鼠标中键 click.middle
    // slice(-1) 截取最后一个 slice(0) 从第一位开始截取
    // contextmenu.prevent 鼠标右键
    const scrollPaneRef = ref(null)
    const store = useStore();
    const instance = getCurrentInstance()
    const { t } = useI18n();
    const router = useRouter()
    const currentRoute = useRoute()
     const { proxy } = instance as any
    const toLastView = (visitedViews: TagView[], view: TagView) => {
      const latestView = visitedViews.slice(-1)[0]
      if (latestView !== undefined && latestView.fullPath !== undefined) {
        router.push(latestView.fullPath).catch(err => {
          console.warn(err)
        })
      } else {
      // Default redirect to the home page if there is no tags-view, adjust it if you want
        if (view.name === 'Dashboard') {
        // to reload home page
          router.push({ path: '/redirect' + view.fullPath }).catch(err => {
            console.warn(err)
          })
        } else {
          router.push('/').catch(err => {
            console.warn(err)
          })
        }
      }
    }
    const visitedViews = computed(() => {
      return store.state.tagViews.visitedViews
    })
    const state = reactive({
      visible: false,
      top: 0,
      left: 0,
      selectedTag: {} as TagView,
      affixTags: [] as TagView[],
      isActive: (route: TagView) => {
        return route.path === currentRoute.path
      },
      isAffix: (tag: TagView) => {
        return tag.meta && tag.meta.affix
      },
      closeSelectedTag: (view: TagView) => {
        store.dispatch(TagsActionTypes.ACTION_DEL_VIEW, view)
        if (state.isActive(view)) {
          toLastView(store.state.tagViews.visitedViews, view)
        }
      },
      refreshSelectedTag: (view: TagView) => {
        store.dispatch(TagsActionTypes.ACTION_DEL_CACHED_VIEW, view)
        const { fullPath } = view
        console.log(fullPath)
        nextTick(() => {
          router.replace({ path: '/redirect' + fullPath }).catch(err => {
            console.warn(err)
          })
        })
      },
      closeOthersTags: () => {
        if (state.selectedTag.fullPath !== currentRoute.path && state.selectedTag.fullPath !== undefined) {
          router.push(state.selectedTag.fullPath).catch(err => {
            console.log(err)
          })
        }
        store.dispatch(TagsActionTypes.ACTION_DEL_OTHER_VIEW, state.selectedTag as TagView)
      },
      closeAllTags: (view: TagView) => {
        store.dispatch(TagsActionTypes.ACTION_DEL_ALL_VIEWS, undefined)
        if (state.affixTags.some(tag => tag.path === currentRoute.path)) {
          return
        }
        toLastView(store.state.tagViews.visitedViews, view)
      },
      openMenu: (tag: TagView, e: MouseEvent) => {
        const menuMinWidth = 105
        const offsetLeft = proxy.$el.getBoundingClientRect().left // container margin left
        const offsetWidth = proxy.$el.offsetWidth // container width
        const maxLeft = offsetWidth - menuMinWidth // left boundary
        const left = e.clientX - offsetLeft + 15 // 15: margin right
        if (left > maxLeft) {
          state.left = maxLeft
        } else {
          state.left = left
        }
        state.top = e.clientY
        state.visible = true
        state.selectedTag = tag
      },
      closeMenu: () => {
        state.visible = false
      },
      handleScroll: () => {
        state.closeMenu()
      }
    })
    const routes = computed(() => store.state.permission.routes)
    const filterAffixTags = (routes: RouteRecordRaw[], basePath = '/') => {
      let tags: TagView[] = []

      routes.forEach(route => {
        if (route.meta && route.meta.affix) {
          // const tagPath = path.resolve(basePath, route.path)
          const tagPath =(() =>{
            if(basePath == '/') return basePath+route.path;
            if(!basePath.startsWith('/')&&!route.path.startsWith('/')) return '/'+ basePath+'/'+route.path;
            if(!basePath.startsWith('/')&&route.path.startsWith('/')) return '/'+ basePath+route.path;
            return basePath+route.path;
          })()
          tags.push({
            fullPath: tagPath,
            path: tagPath,
            name: route.name,
            meta: { ...route.meta }
          })
        }

        if (route.children) {
          const childTags = filterAffixTags(route.children, route.path)
          if (childTags.length >= 1) {
            tags = tags.concat(childTags)
          }
        }
      })
      return tags
    }
    const initTags = () => {
      state.affixTags = filterAffixTags(routes.value)
      for (const tag of state.affixTags) {
        // Must have tag name
        if (tag.name) {
          store.dispatch(TagsActionTypes.ACTION_ADD_VISITED_VIEW, tag as TagView)
        }
      }
    }
    const moveToCurrentTag = () => {
       const tags = instance?.refs.tag as any[]
        nextTick(() => {
        if (tags === null || tags === undefined || !Array.isArray(tags)) { return }
        for (const tag of tags) {
          if ((tag.to as TagView).path === currentRoute.path) {
            (scrollPaneRef.value as any).moveToCurrentTag(tag)
            // When query is different then update
            if ((tag.to as TagView).fullPath !== currentRoute.fullPath) {
              store.dispatch(TagsActionTypes.ACTION_UPDATE_VISITED_VIEW, currentRoute)
            }
          }
        }
      })
    }
    const addTags = () => {
      if (currentRoute.name) {
        console.log(currentRoute.name, 'currentRoute.namecurrentRoute.namecurrentRoute.namecurrentRoute.namecurrentRoute.namecurrentRoute.namecurrentRoute.namecurrentRoute.name')
        store.dispatch(TagsActionTypes.ACTION_ADD_VIEW, currentRoute)
      }
      return false
    }
    watch(() => currentRoute.name, () => {
      if (currentRoute.name !== 'Login') {
        addTags()
        moveToCurrentTag()
      }
    })
    watch(()=>state.visible,(value) => {
      if (value) {
        document.body.addEventListener('click',state.closeMenu);
      }else {
        document.body.removeEventListener('click',state.closeMenu);
      }
    })
    onBeforeMount(()=>{
       initTags()
       addTags()
    })
    return {
      t,
      scrollPaneRef,
      visitedViews,
       ...toRefs(state)
    }
  },
  components: {
    ScrollPane
  }
});
</script>
<style lang="scss" scoped>
// Reset element css of el-icon-close
.tags-view-wrapper {
  .tags-view-item {
    .el-icon-close {
      width: 16px;
      height: 16px;
      vertical-align: 2px;
      border-radius: 50%;
      text-align: center;
      transition: all 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);
      transform-origin: 100% 50%;

      &:before {
        transform: scale(0.6);
        display: inline-block;
        vertical-align: -3px;
      }

      &:hover {
        background-color: #b4bccc;
        color: #fff;
      }
    }
  }
}
</style>
<style lang="scss" scoped>
.tags-view-container {
  height: 34px;
  width: 100%;
  background: #fff;
  border-bottom: 1px solid #d8dce5;
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.12), 0 0 3px 0 rgba(0, 0, 0, 0.04);
  .tags-view-wrapper {
    .tags-view-item {
      display: inline-block;
      position: relative;
      cursor: pointer;
      height: 26px;
      line-height: 26px;
      border: 1px solid #d8dce5;
      color: #495060;
      background: #fff;
      padding: 0 8px;
      font-size: 12px;
      margin-left: 5px;
      margin-top: 4px;
      &:first-of-type {
        margin-left: 15px;
      }
      &:last-of-type {
        margin-right: 15px;
      }
      &.active {
        background-color: #42b983;
        color: #fff;
        border-color: #42b983;
        &::before {
          content: '';
          background: #fff;
          display: inline-block;
          width: 8px;
          height: 8px;
          border-radius: 50%;
          position: relative;
          margin-right: 2px;
        }
      }
    }
  }
  .contextmenu {
    margin: 0;
    background: #fff;
    z-index: 3000;
    position: absolute;
    list-style-type: none;
    padding: 5px 0;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 400;
    color: #333;

    li {
      margin: 0;
      padding: 7px 16px;
      cursor: pointer;

      &:hover {
        background: #eee;
      }
    }
  }
}
</style>