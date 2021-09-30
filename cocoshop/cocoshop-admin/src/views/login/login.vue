<template>
  <div class="login-container">
    <el-form ref="formRef" class="login-form" :model="loginForm" :rules="getFormRules" auto-complete="on" label-position="left">
      <div class="title-container">
         <h3 class="title">{{t('login.title')}}</h3>
         <lang-select class="set-language"/>
      </div>
      <el-form-item prop="username">
          <span class="svg-container">
            <svg-icon icon-class="user" />
          </span>
          <el-input
            name="username"
            v-model="loginForm.username"
            type="text"
            auto-complete="on"
            :placeholder="t('login.username')"
          />
      </el-form-item>
      <el-form-item prop="password">
        <span class="svg-container">
          <svg-icon icon-class="password" />
        </span>
        <el-input
          name="password"
          v-model="loginForm.password"
          auto-complete="on"
          :placeholder="t('login.password')"
           />
        <span class="show-pwd" >
          <svg-icon icon-class="eye" />
        </span>
      </el-form-item>
      <el-button :loading="loading" type="info"  @click="handleLogin" style="width:100%;margin-bottom:30px;">{{ t('login.logIn') }}</el-button>
    </el-form>
  </div>
</template>
<script lang="ts">
import { defineComponent, reactive, ref, unref} from 'vue';
import {  ElForm,ElFormItem,ElInput,ElButton } from  'element-plus';
import LangSelect from '/@/components/LangSelect/index.vue'
import { useI18n } from "/@/hook/web/useI18n";
import { useFormRules,useFormValid} from './useLogin';
// import instance from '/@/api/user';
import { login } from '/@/api/user';
export default defineComponent({
  name: 'login',
  setup() {
    
     const { t } = useI18n();
     const formRef = ref();
     const { getFormRules } = useFormRules();

     const loginForm = reactive({
        username: 'admin',
        password: 'admin'
     })
     const { validForm } = useFormValid(formRef);

     async function handleLogin (){
        const data = await validForm();
        // instance.authLogin(unref(loginForm));
        login(unref(loginForm)).then(res=>{
          
        });
     }
     return {t,formRef,loginForm,getFormRules,handleLogin}
  },
  components: {
    ElForm,
    ElFormItem,
    ElInput,
    ElButton,
    LangSelect
  }
});
</script>
<style lang="scss">
$bg:#283443;
$light_gray:#eee;
$cursor: #fff;

@supports (-webkit-mask: none) and (not (cater-color: $cursor)) {
  .login-container .el-input input{
    color: $cursor;
    &::first-line {
      color: $light_gray;
    }
  }
}

/* reset element-ui css */
.login-container {
  .el-input {
    display: inline-block;
    height: 47px;
    width: 85%;
    input {
      background: transparent;
      border: 0px;
      -webkit-appearance: none;
      border-radius: 0px;
      padding: 12px 5px 12px 15px;
      color: $light_gray;
      height: 47px;
      caret-color: $cursor;
      &:-webkit-autofill {
        -webkit-box-shadow: 0 0 0px 1000px $bg inset !important;
        -webkit-text-fill-color: $cursor !important;
      }
    }
  }
  .el-form-item {
    border: 1px solid rgba(255, 255, 255, 0.1);
    background: rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    color: #454545;
  }
}
$bg: #2d3a4b;
$dark_gray: #889aa4;
$light_gray: #eee;
.login-container {
  background-image: url('../../assets/bg.jpg');
  background-size: 100% 100%;
  height: 100%;
  width: 100%;
  overflow: hidden;
  .login-form {
    position: relative;
    width: 520px;
    max-width: 100%;
    padding: 160px 35px 0;
    margin: 0 auto;
    overflow: hidden;
    .title-container {
      position: relative;
      .title {
        font-size: $font_46;
        color: $light_gray;
        margin: 0px auto 40px auto;
        text-align: center;
        font-weight: bold;
      }
      .set-language {
        color: #fff;
        position: absolute;
        top: 5px;
        right: 0px;
      }
    }
    .svg-container {
      padding: 6px 5px 6px 15px;
      color: $dark_gray;
      vertical-align: middle;
      width: 30px;
      display: inline-block;
   }

  }
}
</style>