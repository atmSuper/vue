export enum DeviceType {
  Mobile,
  Desktop,
}

export interface AppState {
  device: DeviceType
  sidebar: {
    opened: boolean
    withoutAnimation: boolean
  }
  // language: string
  // size: string
}

export const state: AppState = {
  device: DeviceType.Desktop,
  sidebar: {
    opened:true,
    withoutAnimation: false
  },
  // language: getLocale(),
  // size: getSize() || 'medium'
}
