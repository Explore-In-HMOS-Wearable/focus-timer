import {
  ArcDirection,
  ArcDotIndicator,
  ArcSwiper,
  ArcSwiperAttribute
} from '@kit.ArkUI'

import ProgressController from '../components/ProgressController'
import ProgressRing from '../components/ProgressRing'
import ProgressTimes from '../components/ProgressTimes'
import Program from '../model/Program'
import Timer from '../model/Timer'
import { FocusType } from '../model/FocusType'

@Entry
@Component
struct Index {
  private arcDotIndicator: ArcDotIndicator = new ArcDotIndicator();

  @State @Watch('updateFocus') program: Program = new Program()
  @State currentFocusType: FocusType = this.program.currentFocus.type;
  @State timer: Timer = new Timer(this.program.currentFocus.value * 60, () => {
    this.program.skip()
  })

  updateFocus() {
    let currentFocus = this.program.currentFocus;
    if (currentFocus.type != this.currentFocusType) {
      // Current focus changed
      this.currentFocusType = currentFocus.type
      this.timer.refresh(currentFocus.value * 60)
    }
  }

  build() {
    ArcSwiper() {
      ProgressController({
        timer: this.timer,
        progressType: this.currentFocusType,
        program: this.program
      })

      ProgressRing({
        timer: this.timer,
        progressType: this.currentFocusType,
      })

      ProgressTimes({
        program: this.program
      })
    }
    .indicator(
      this.arcDotIndicator
        .arcDirection(ArcDirection.SIX_CLOCK_DIRECTION)
        .maskColor(new LinearGradient([{
          color: Color.Transparent,
          offset: $r('app.float.offset_zero'),
        }]))
    )
    .effectMode(EdgeEffect.None)
    .index(1)
  }
}