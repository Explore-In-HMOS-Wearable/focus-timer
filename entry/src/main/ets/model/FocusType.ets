export enum FocusType {
  focus,
  shortBreak,
  longBreak,
}

export function focusName(type: FocusType, full: boolean = false) {
  switch (type) {
    case FocusType.focus:
      return $r('app.string.focus')
    case FocusType.shortBreak:
      return full ? $r('app.string.short_break') : $r('app.string.break')
    case FocusType.longBreak:
      return full ? $r('app.string.long_break') : $r('app.string.break')
  }
}