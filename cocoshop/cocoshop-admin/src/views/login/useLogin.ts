import { ref, computed, unref, Ref } from 'vue';
import { useI18n } from "/@/hook/web/useI18n";

export function useFormValid<T extends Object = any>(formRef: Ref<any>) {
    async function validForm() {
      const form = unref(formRef);
      if (!form) return;
      const data = await form.validate();
      return data as T;
    }
    return { validForm };
}
export function useFormRules() {
    
    const { t } = useI18n();
    const validatePassword = async (rule, value, callback) =>{
        if (value.length < 5) {
            return Promise.reject(callback(new Error(t('login.errorPassword'))))
        } 
        return Promise.resolve(callback());
    }
    const validateUsername = async (rule, value, callback) => {
        if (value.length < 5) {
            return Promise.reject(callback(new Error(t('login.errorAccount') )))
        }
        return Promise.resolve(callback());
    }
    const getAccountFormRule = computed(() => createRule(validateUsername));
    const getPasswordFormRule = computed(() => createRule(validatePassword));
    const getFormRules = computed(()=>{
        const accountFormRule = unref(getAccountFormRule);
        const passwordFormRule = unref(getPasswordFormRule);
        return {
            username: accountFormRule,
            password: passwordFormRule,
        };
    })
    return { getFormRules }
}
function createRule(rule) {
   return [
       {
           require:true,
           validator:rule,
           trigger: 'blur'
       }
   ]
}