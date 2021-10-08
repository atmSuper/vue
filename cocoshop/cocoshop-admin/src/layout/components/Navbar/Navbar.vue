<template>
  <div class="navbar">
    <hm-burger
      :is-active="sidebar.opened"
      @toggleClick="toggleSideBar"
      class="hamburger-container"
    ></hm-burger>
    <breadcrumb class="breadcrumb-container" id="breadcrumb-container" />

    <div class="right-menu">
      <a href="javascript:void(0)" class="wd" style="vertical-align: text-bottom;color:lightblue;">官方文档</a>
      <div class="international right-menu-item"><lang-select /></div>
      <div class="avatar-container right-menu-item">
        <el-dropdown trigger="click">
          <div class="avatar-wrapper">
            <img class="user-avatar" :src="avatar" />
            <i class="el-icon-caret-bottom" />
          </div>
          <template #dropdown>
            <el-dropdown-menu>
              <router-link to="/account/profile">
                <el-dropdown-item>
                  {{ t('navbar.profile') }}
                </el-dropdown-item>
              </router-link>
              <router-link to="/account/updatePwd">
                <el-dropdown-item>
                  {{ t('navbar.updatePwd') }}
                </el-dropdown-item>
              </router-link>
              <el-dropdown-item divided>
                <span style="display: block">{{ t('navbar.logOut') }}</span>
              </el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
    </div>
  </div>
</template>

<script>
import { computed, defineComponent, reactive, toRefs} from 'vue';
import HmBurger from '/@/components/Hamburger/index.vue';
import Breadcrumb from '/@/components/Breadcrumb/index.vue';
import LangSelect from '/@/components/LangSelect/index.vue';
import { useLocaleStoreWithOut } from '/@/store/modules/locale';
import { ElDropdown, ElDropdownMenu, ElDropdownItem } from 'element-plus';
import { useI18n } from "/@/hook/web/useI18n";
import avatar from '/@/assets/img/avatar.gif';

import { useStore } from '/@/vux';
import { AppActionTypes } from '/@/vux/modules/app/action-types'
export default defineComponent({
  name: 'Navbar',
  setup() {
    const { t } = useI18n();
    
    let useLocale = useLocaleStoreWithOut();
    // let sidebar = computed(() => {
    //   return useLocale.getSidebar;
    // });
    // const toggleSideBar = () => {
    //   console.log(ref(sidebar).value.opened);
    //   useLocale.setSidebar({ opened: !ref(sidebar).value.opened });
    // };

    // vuex 写法
    const store = useStore();
    
    const sidebar = computed(() => {
      return store.state.app.sidebar
    })

    const state = reactive({
      toggleSideBar: () => {
        store.dispatch(AppActionTypes.ACTION_TOGGLE_SIDEBAR, false)
      },
     })

    

    return {
      t,
      sidebar,
      avatar,
       ...toRefs(state),
    };
  },
  components: {
    HmBurger,
    Breadcrumb,
    ElDropdown,
    ElDropdownMenu,
    ElDropdownItem,
    LangSelect
  }
});
</script>

<style lang="scss" scoped>
.navbar {
  height: 50px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);

  .hamburger-container {
    line-height: 46px;
    height: 100%;
    float: left;
    padding: 0 15px;
    cursor: pointer;
    transition: background-color 0.3s;
    -webkit-tap-highlight-color: transparent;

    &:hover {
      background: rgba(0, 0, 0, 0.025);
    }
  }

  .breadcrumb-container {
    float: left;
  }

  .errLog-container {
    display: inline-block;
    vertical-align: top;
  }

  .right-menu {
    float: right;
    height: 100%;
    line-height: 50px;

    &:focus {
      outline: none;
    }

    .right-menu-item {
      display: inline-block;
      padding: 0 8px;
      height: 100%;
      font-size: 18px;
      color: #5a5e66;
      vertical-align: text-bottom;

      &.hover-effect {
        cursor: pointer;
        transition: background-color 0.3s;

        &:hover {
          background: rgba(0, 0, 0, 0.025);
        }
      }
    }

    .avatar-container {
      .avatar-wrapper {
        margin-top: 5px;
        margin-right: 16px;
        margin-left: 16px;
        position: relative;

        .user-avatar {
          cursor: pointer;
          width: 40px;
          height: 40px;
          border-radius: 10px;
        }

        .el-icon-caret-bottom {
          cursor: pointer;
          position: absolute;
          right: -20px;
          top: 25px;
          font-size: 12px;
        }
      }
    }
  }
}
</style>