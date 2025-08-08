import { CounterComponent, CounterType } from '@ohos.arkui.advanced.Counter';
import Program from '../model/Program';
import Focus from '../model/Focus';
import { focusName } from '../model/FocusType';
import { SizeConstants } from '../constants/SizeConstants';

@Component
export default struct ProgressTimes {
  @ObjectLink program: Program;
  private focuses = this.program.getFocusList()

  build() {
    Column() {
      List() {
        ForEach(this.focuses, (focus: Focus) => {
          ListItem() {
            Column() {
              Text(focusName(focus.type, true))
              CounterComponent({
                options: {
                  type: CounterType.COMPACT,
                  numberOptions: {
                    value: focus.value,
                    min: 5,
                    max: 30,
                    textWidth: 30,
                    focusable: false,
                    onChange: (val: number) => {
                      this.program.changeDefaultTime(focus.type, val)
                    }
                  },
                }
              })
            }
            .width(SizeConstants.FULL_WIDTH_PERCENT)
          }
        }, (item: Focus, index: number) => `${index} ${JSON.stringify(item)}`)
      }
    }
    .width(SizeConstants.FULL_WIDTH_PERCENT)
    .height(SizeConstants.FULL_HEIGHT_PERCENT)
  }
}