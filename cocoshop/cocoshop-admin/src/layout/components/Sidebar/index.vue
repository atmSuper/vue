<template>
    <div 
    class="sideWrap"
    :class="{'has-logo': showLogo}"
    >
     <SidebarLogo
      v-if="showLogo"
      :collapse="isCollapse"
    />
    <el-scrollbar wrap-class="scrollbar-wrapper">
         <el-menu 
          :collapse="!isCollapse"
          :unique-opened="false"
          :default-active="activeMenu"
          :background-color="variables.menuBg"
          :text-color="variables.menuText"
          :active-text-color="menuActiveTextColor"
          mode="vertical"
          >
          <SidebarItem
          v-for="route in routes"
          :key="route.path"
          :item="route"
          :base-path="route.path"
          :is-collapse="isCollapse"
        />
        </el-menu>
    </el-scrollbar>
    </div>
</template>

<script lang="ts">
import { defineComponent, reactive, computed} from 'vue'
import { ElScrollbar, ElMenu} from 'element-plus';
import SidebarItem from './SidebarItem.vue';
import SidebarLogo from './SidebarLogo.vue';
import { useStore } from '/@/vux';
import { useRoute } from 'vue-router'
// import variables from '/@/styles/variables.scss';

export default defineComponent({
  setup() {
    const store = useStore();
    const route = useRoute()
    const showLogo = computed(() => {
      return store.state.settings.showSidebarLogo
    })

    const sidebar = computed(() => {
      return store.state.app.sidebar
    })

    const isCollapse = computed(() => {
      return sidebar.value.opened
    })

    const routes = computed(() => {
      return store.state.permission.routes
    })
    const menuActiveTextColor = computed(() => {
      return '#57CAEB'
    })

     const activeMenu = computed(() => {
      const { meta, path } = route
      if (meta !== null || meta !== undefined) {
        if (meta.activeMenu) {
          return meta.activeMenu
        }
      }
      return path
    })
    const variables = reactive({
       menuText:"#162B64",
       menuBg:"#fff",
       menuActiveText:"#435EBE"
    })  
    return {
      variables,
      showLogo,
      isCollapse,
      menuActiveTextColor,
      activeMenu,
      routes
    }
  },
   components: {
    ElScrollbar,
    ElMenu,
    SidebarItem,
    SidebarLogo
  }
})
</script>
<style lang="scss">
.sidebar-container {
  // reset element-ui css
  .horizontal-collapse-transition {
    transition: 0s width ease-in-out, 0s padding-left ease-in-out,
      0s padding-right ease-in-out;
  }

  .scrollbar-wrapper {
    overflow-x: hidden !important;
  }

  .el-scrollbar__view {
    height: 100%;
  }

  .el-scrollbar__bar {
    &.is-vertical {
      right: 0px;
    }

    &.is-horizontal {
      display: none;
    }
  }
}
</style>

<style lang="scss" scoped>
.el-scrollbar {
  height: 100%;
}
.has-logo {
  .el-scrollbar {
    height: calc(100vh - 100px);
  }
}
.el-menu {
  border: none;
  height: 100%;
  width: 100% !important;
}
</style>