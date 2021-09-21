<template>
  <div class="login-container">
    <Form class="login-form">
      <!-- <FormItem name="account">
              <Input
              size="large"
              />
          </FormItem> -->
      <div class="title-container">
        <h3 class="title">邻家小铺</h3>
      </div>
    </Form>
  </div>
</template>
<script lang="ts">
import { defineComponent } from 'vue';
import { Checkbox, Form, Input, Row, Col, Button, Divider } from 'ant-design-vue';
export default defineComponent({
  name: 'login',
  setup() {},
  components: {
    Form,
    FormItem: Form.Item,
    Input
  }
});
</script>
<style lang="scss">
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
  }
}
</style>