import Focus from './Focus'
import { FocusType } from './FocusType'

@Observed
export default class Program {
  focusTimes: Map<FocusType, number> = AppStorage.get('defaultTimes') ?? defaultFocus
  readonly program: FocusType[] = [
    FocusType.focus,
    FocusType.shortBreak,
    FocusType.focus,
    FocusType.shortBreak,
    FocusType.focus,
    FocusType.longBreak
  ]
  private programIndex: number = AppStorage.get('programIndex') ?? 0
  currentFocus = this.getCurrentFocus()

  getCurrentFocus() {
    let currentType = this.program[this.programIndex]
    let currentFocus: Focus = {
      type: currentType,
      value: this.focusTimes.get(currentType)!
    }
    return currentFocus
  }

  getFocusList() {
    let focusList: Focus[] = []
    this.focusTimes.forEach((value: number, type: FocusType) => {
      focusList.push({ type: type, value: value })
    })
    return focusList
  }

  skip() {
    this.programIndex = (this.programIndex + 1) % this.program.length
    this.currentFocus = this.getCurrentFocus()
    this.setProgramIndex(this.programIndex)
  }

  changeDefaultTime(type: FocusType, val: number) {
    this.focusTimes.set(type, val)
    AppStorage.setOrCreate('defaultTimes', this.focusTimes)
  }

  setProgramIndex(index: number) {
    AppStorage.setOrCreate('programIndex', index)
  }
}

const defaultFocus = new Map<FocusType, number>([
  [FocusType.focus, 25],
  [FocusType.shortBreak, 5],
  [FocusType.longBreak, 20]
])