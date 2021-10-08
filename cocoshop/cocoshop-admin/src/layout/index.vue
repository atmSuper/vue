<template>
  <div class="app-wrapper" :class="classObj">
    <sidebar class="sidebar-container" />
    <div :class="{ hasTagsView: showTagsView }" class="main-container">
      <div :class="{'fixed-header': fixedHeader}">
        <navbar />
        <tast-view  v-if="showTagsView" />
      </div>
      <app-main />
    </div>
  </div>
</template>
<script lang="ts">
import { defineComponent, reactive, ref, unref, computed } from 'vue';
import { Sidebar, Navbar, TastView, AppMain } from './components';
import { useStore } from '/@/vux';
import resize from  "/@/hook/layout/resize";
export default defineComponent({
  name: 'Layout',
  setup() {
    
    const { sidebar } = resize()

    const store = useStore();
    const showTagsView = computed(() => {
      return store.state.settings.showTagsView;
    });
    const fixedHeader = computed(() => {
      return store.state.settings.fixedHeader;
    });
    const classObj = computed(() => {
      return {
        hideSidebar: !sidebar.value.opened,
        openSidebar: sidebar.value.opened,
        withoutAnimation: sidebar.value.withoutAnimation,
      }
    })
    return {
      showTagsView,
      fixedHeader,
      classObj
    };
  },
  components: {
    Sidebar,
    Navbar,
    TastView,
    AppMain
  }
});
</script>
<style lang="scss" scoped>
@import '../styles/variables.scss';
@import '../styles/mixin.scss';

.app-wrapper {
  @include clearfix;
  position: relative;
  height: 100%;
  width: 100%;
}
.main-container {
  min-height: 100%;
  transition: margin-left 0.28s;
  margin-left: $sideBarWidth;
  position: relative;
}
.sidebar-container {
  transition: width 0.28s;
  width: $sideBarWidth !important;
  height: 100%;
  position: fixed;
  font-size: 0px;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 1001;
  overflow: hidden;
  background-color: #ffffff !important;
}
.hideSidebar {
  .main-container {
    margin-left: 54px;
  }

  .sidebar-container {
    width: 54px !important;
  }

  .fixed-header {
    width: calc(100% - 54px)
  }
}
</style>