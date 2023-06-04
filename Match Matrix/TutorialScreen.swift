import SwiftUI

struct StopWatchView: View {
    @State var timeElapsed: TimeInterval = 0.0
    @State var timerMode: TimerMode = .stopped
    var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("\(timeElapsed.formattedMilliseconds())")
                .font(.largeTitle)
                .padding(.top, 30)
            HStack {
                Button(action: {
                    start()
                }, label: {
                    Text("Start")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                Button(action: {
                    pause()
                }, label: {
                    Text("Pause")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.yellow)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                Button(action: {
                    stop()
                }, label: {
                    Text("Stop")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                Button(action: {
                    reset()
                }, label: {
                    Text("Reset")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
            }
        }
        .onReceive(timer) { _ in
            updateTime()
        }
    }

    enum TimerMode {
        case running, paused, stopped
    }

    func updateTime() {
        if timerMode == .running {
            timeElapsed += 0.01
        }
    }

    func start() {
        timerMode = .running
    }

    func pause() {
        timerMode = .paused
    }

    func stop() {
        timerMode = .stopped
        timeElapsed = 0.0
    }

    func reset() {
        stop()
        start()
    }
}

extension TimeInterval {
    func formattedMilliseconds() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        let milliseconds = Int(self * 100) % 100
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}
