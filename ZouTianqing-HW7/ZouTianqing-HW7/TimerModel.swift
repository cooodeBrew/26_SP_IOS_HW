// Project: ZouTianqing-HW7
// EID: tz4654
// Course: CS371L

import Foundation

class TimerModel {
    var event: String
    var location: String
    var remainingTime: Int

    init(event: String, location: String, remainingTime: Int) {
        self.event = event
        self.location = location
        self.remainingTime = remainingTime
    }
}
