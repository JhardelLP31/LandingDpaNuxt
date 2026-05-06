// plugins/recaptcha.client.ts
import { defineNuxtPlugin } from '#app';
import { VueReCaptcha } from 'vue-recaptcha-v3';

export default defineNuxtPlugin((nuxtApp) => {
  nuxtApp.vueApp.use(VueReCaptcha, {
    siteKey: '6LebI98aAAAAAIFmLk_nQrn-v0COUf5ruzjZS3px', 
    loaderOptions: {
      useRecaptchaNet: true,
      autoHideBadge: true 
    }
  });
});