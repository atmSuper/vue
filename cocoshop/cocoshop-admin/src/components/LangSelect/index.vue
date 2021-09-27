<template>
    <el-dropdown trigger="click" class="international" @command="handleSetLanguage">
    <div>
      <svg-icon class-name="international-icon" icon-class="language" />
    </div>
    <template #dropdown>
    <el-dropdown-menu>
      <el-dropdown-item command="zh">中文</el-dropdown-item>
      <el-dropdown-item command="en">English</el-dropdown-item>
    </el-dropdown-menu>
    </template>
  </el-dropdown>
</template>
<script lang="ts">
import type { LocaleType } from '/#/config';
import {defineComponent,computed,ref} from 'vue';
import {ElDropdown,ElDropdownItem,ElDropdownMenu} from  'element-plus';
import { useLocale } from '/@/locale/useLocale';
export default defineComponent({
  name: 'LangSelect',
  props: {
   
  },
  setup(props) {
      const language = ref('zh')
      const { changeLocale } = useLocale();
      const handleSetLanguage=(command:string) =>{
          changeLocale(command as LocaleType);
      }
      return {handleSetLanguage} 
  },
  components:{
    ElDropdown,
    ElDropdownItem,
    ElDropdownMenu
  }
})
</script>
<style scoped>
 .international-icon {
  font-size: 20px;
  cursor: pointer;
  vertical-align: -5px!important;
}
</style>
