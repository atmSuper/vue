import { App } from 'vue'
import { ElButton } from 'element-plus'

export default function (app: App): App {
  app.use(ElButton)
  return app
}
