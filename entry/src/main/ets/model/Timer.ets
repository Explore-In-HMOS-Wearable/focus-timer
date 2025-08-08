/**
 * goal in seconds
 * */
@Observed
export default class Timer {
  private initialGoal: number;
  goal: number;
  progress: number = 0;
  running: boolean = false
  timerEndCallback: () => void;

  constructor(goal: number, timerEndCallback: () => void = () => {
  }) {
    this.initialGoal = goal
    this.goal = goal
    this.timerEndCallback = timerEndCallback
  }

  addFiveSeconds() {
    this.goal += 5 * 60
  }

  private intervalId: number | undefined = undefined;

  start() {
    this.intervalId = setInterval(() => {
      this.progress++;
      if (this.progress == this.goal) {
        this.stop();
        this.timerEndCallback()
      }
    }, 1000)
    this.running = true
  }

  stop() {
    clearInterval(this.intervalId)
    this.running = false
  }

  reset() {
    clearInterval(this.intervalId)
    this.goal = this.initialGoal
    this.progress = 0
    this.running = false
  }

  refresh(goal: number) {
    clearInterval(this.intervalId)
    this.initialGoal = goal;
    this.goal = goal;
    this.progress = 0
    this.running = false
  }

  formattedTime() {
    let remaining = this.goal - this.progress
    let seconds = remaining % 60
    let minutes = (remaining - seconds) / 60
    return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`
  }

}