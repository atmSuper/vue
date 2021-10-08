<template>
  <div
     v-if="!item.meta || !item.meta.hidden"
    :class="[isCollapse ? 'simple-mode' : 'full-mode', { 'first-level': isFirstLevel }]"
  >
     <template
      v-if="!alwaysShowRootMenu && theOnlyOneChild && !theOnlyOneChild.children"
    >
      <SidebarItemLink
        v-if="theOnlyOneChild.meta"
        :to="resolvePath(theOnlyOneChild.path)"
      >
        <el-menu-item
          :index="resolvePath(theOnlyOneChild.path)"
          :class="{'submenu-title-noDropdown': isFirstLevel}"
        >
          <svg-icon :icon-class="theOnlyOneChild.meta.icon" :Size="'17px'" v-if="theOnlyOneChild.meta.icon" />
          <span v-if="theOnlyOneChild.meta.title">{{
            t("route." + theOnlyOneChild.meta.title)
          }}</span>
        </el-menu-item>
      </SidebarItemLink>
    </template>
    <el-submenu v-else :index="resolvePath(item.path)">
      <template #title>
          <svg
            v-if="item.meta && item.meta.icon"
            class="icon"
            aria-hidden="true"
            font-size="16px"
              >
              <use :xlink:href="item.meta.icon" />
            </svg>
            <span v-if="item.meta && item.meta.title">{{
               t("route." + item.meta.title)
            }}</span>
      </template>
    </el-submenu>
  </div>
</template>
<script lang='ts'>
import { defineComponent, reactive, PropType, computed } from 'vue';
import { ElMenu, ElMenuItem, ElMenuItemGroup, ElSubmenu } from 'element-plus';
import { RouteRecordRaw } from 'vue-router';
import { isExternal } from '/@/utils/is';
import SidebarItemLink from './SidebarItemLink.vue'
import { useI18n } from "/@/hook/web/useI18n";
export default defineComponent({
  name: 'SidebarItem',
  components: {
    ElMenu,
    ElMenuItem,
    ElMenuItemGroup,
    ElSubmenu,
    SidebarItemLink
  },
  props: {
    item: {
      type: Object as PropType<RouteRecordRaw>,
      required: true
    },
    isCollapse: {
      type: Boolean,
      required: false
    },
    isFirstLevel: {
      type: Boolean,
      required: true
    },
    basePath: {
      type: String,
      required: true
    }
  },
  setup(props) {
    const { t } = useI18n();
    const alwaysShowRootMenu = computed(() => {
      if (props.item.meta && props.item.meta.alwaysShow) {
        return true;
      } else {
        return false;
      }
    });
    const showingChildNumber = computed(() => {
      if (props.item.children) {
        const showingChildren = props.item.children.filter((item) => {
          if (item.meta && item.meta.hidden) {
            return false;
          } else {
            return true;
          }
        });
        return showingChildren.length;
      }
      return 0;
    });
    const theOnlyOneChild = computed(() => {
      if (showingChildNumber.value > 1) {
        return null
      }
      if (props.item.children) {
        for (const child of props.item.children) {
          if (!child.meta || !child.meta.hidden) {
            return child
          }
        }
      }
      return { ...props.item, path: '' }
    })
    const resolvePath = (routePath: string) => {
      if (isExternal(routePath)) {
        return routePath;
      }
      if (isExternal(props.basePath)) {
        return props.basePath;
      }
      if(!routePath) return props.basePath;
      if(props.basePath== routePath) return props.basePath;
      else if(props.basePath=='/') return props.basePath+routePath;
      else if(routePath.indexOf('/')> -1) return props.basePath+routePath;
      else return props.basePath+'/'+routePath;
    };
    return {
      t,
      resolvePath,
      alwaysShowRootMenu,
      showingChildNumber,
      theOnlyOneChild,
    };
  }
});
</script>
<style lang="scss" scoped>
.el-submenu.is-active > .el-submenu__title {
  color: $subMenuActiveText !important;
}

.full-mode {
  .nest-menu .el-submenu > .el-submenu__title,
  .el-submenu .el-menu-item {
    min-width: $sideBarWidth !important;
    background-color: $subMenuBg !important;

    &:hover {
      background-color: $subMenuHover !important;
    }
  }
  .el-menu-item{
    &>span{
      display: inline-block;
      padding-left: 5px;
    }
  }
  .el-submenu {
    overflow: hidden;

    & > .el-submenu__title {
      .el-submenu__icon-arrow {
        display: none;
      }

      & > span {
             padding-left: 5px;

      }
    }
  }
}

.simple-mode {
  &.first-level {
    .submenu-title-noDropdown {
      padding: 0 !important;
      position: relative;

      .el-tooltip {
        padding: 0 !important;
      }
    }

    .el-submenu {
      overflow: hidden;

      & > .el-submenu__title {
        padding: 0px !important;

        .el-submenu__icon-arrow {
          display: none;
        }

        & > span {
          visibility: hidden;
        }
      }
    }
  }
}
</style>

<style lang="scss" scoped>
svg {
  margin-right: 16px;
}

.simple-mode {
  svg {
    margin-left: 20px;
  }
}
</style>