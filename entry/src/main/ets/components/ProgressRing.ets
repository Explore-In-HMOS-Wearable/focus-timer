import { SizeConstants } from '../constants/SizeConstants';
import { focusName, FocusType } from '../model/FocusType';
import Timer from '../model/Timer';

@Component
export default struct ProgressRing {
  @ObjectLink timer: Timer;
  @Require @Prop progressType: FocusType;
  private _purpleGradient: LinearGradient = new LinearGradient([
    { color: $r('app.color.purple_gradient_1'), offset: $r('app.float.offset_0_2') },
    { color: $r('app.color.purple_gradient_2'), offset: $r('app.float.offset_0_4') },
    { color: $r('app.color.purple_gradient_3'), offset: $r('app.float.offset_0_6') },
    { color: $r('app.color.purple_gradient_4'), offset: $r('app.float.offset_0_8') },
    { color: $r('app.color.purple_gradient_5'), offset: $r('app.float.offset_one') },
  ])

  build() {
    Stack() {
      Column() {
        Progress({ value: this.timer.progress, total: this.timer.goal, type: ProgressType.Ring })
          .color(this._purpleGradient)
          .width(SizeConstants.FULL_WIDTH_PERCENT)
          .style({ strokeWidth: $r('app.float.margin_16'), enableSmoothEffect: true, })
          .padding($r('app.float.margin_16'))
      }
      .justifyContent(FlexAlign.Center)
      .size({ width: SizeConstants.FULL_WIDTH_PERCENT, height: SizeConstants.FULL_HEIGHT_PERCENT })

      Column() {
        Text(this.timer.formattedTime())
          .fontSize($r('app.float.progress_font_size'))

        Button() {
          Row() {
            SymbolGlyph(this.timer.running ? $r('sys.symbol.pause') : $r('sys.symbol.play_fill'))
              .fontColor([Color.White])
            Blank().width($r('app.float.margin_4'))
            Text(focusName(this.progressType))
              .fontColor(Color.White)
          }
        }
        .backgroundColor($r('app.color.purple_gradient_5'))
        .padding({
          top: $r('app.float.margin_4'),
          bottom: $r('app.float.margin_4'),
          left: $r('app.float.margin_4'),
          right: $r('app.float.margin_8'),
        })
        .onClick(() => {
          if (this.timer.running) {
            this.timer.stop()
          } else {
            this.timer.start()
          }
        })
      }
    }
  }
}