import { SizeConstants } from '../constants/SizeConstants';
import { focusName, FocusType } from '../model/FocusType';
import Program from '../model/Program';
import Timer from '../model/Timer';

@Component
export default struct ProgressController {
  @Require @Prop progressType: FocusType;
  @ObjectLink timer: Timer;
  @ObjectLink program: Program;

  build() {
    RelativeContainer() {
      Column() {
        Text(focusName(this.progressType, true))
        Grid() {
          GridItem() {
            Column() {
              Button() {
                SymbolGlyph(this.timer.running ? $r('sys.symbol.pause') : $r('sys.symbol.play_fill'))
                  .fontColor([Color.White])
              }
              .width(SizeConstants.FULL_WIDTH_PERCENT)
              .layoutWeight(1)
              .backgroundColor($r('app.color.purple_gradient_5'))
              .onClick(() => {
                if (this.timer.running) {
                  this.timer.stop()
                } else {
                  this.timer.start()
                }
              })

              Blank().height($r('app.float.margin_8'))
              Text(this.timer.running ? $r('app.string.stop') : $r('app.string.start'))
            }
          }

          GridItem() {
            Column() {
              Button() {
                SymbolGlyph($r('sys.symbol.plus'))
                  .fontColor([Color.White])
              }
              .width(SizeConstants.FULL_WIDTH_PERCENT)
              .layoutWeight(1)
              .backgroundColor(Color.Green)
              .onClick(() => this.timer.addFiveSeconds())

              Blank().height($r('app.float.margin_8'))
              Text($r('app.string.plus_five'))
            }
          }

          GridItem() {
            Column() {
              Button() {
                SymbolGlyph($r('sys.symbol.arrow_counterclockwise'))
                  .fontColor([Color.White])
              }
              .width(SizeConstants.FULL_WIDTH_PERCENT)
              .layoutWeight(1)
              .backgroundColor(Color.Blue)
              .onClick(() => {
                this.timer.reset()
              })

              Blank().height($r('app.float.margin_8'))
              Text($r('app.string.reset'))
            }
          }

          GridItem() {
            Column() {
              Button() {
                SymbolGlyph($r('sys.symbol.forward_end_fill'))
                  .fontColor([Color.White])
              }
              .width(SizeConstants.FULL_WIDTH_PERCENT)
              .layoutWeight(1)
              .backgroundColor(Color.Red)
              .onClick(() => this.program.skip())

              Blank().height($r('app.float.margin_8'))
              Text($r('app.string.skip'))
            }
          }

        }
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .columnsGap($r('app.float.margin_8'))
        .rowsGap($r('app.float.margin_8'))
        .padding({ bottom: $r('app.float.margin_8') })
      }
      .size({ width: SizeConstants.PERCENT_70, height: SizeConstants.PERCENT_70 })
      .alignRules({
        center: { anchor: '__container__', align: VerticalAlign.Center },
        middle: { anchor: '__container__', align: HorizontalAlign.Center }
      })
    }
  }
}