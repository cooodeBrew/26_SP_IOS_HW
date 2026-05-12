// Project: ZouTianqing-HW7
// EID: tz4654
// Course: CS371L

import Foundation

/// Shared timer list for Main ↔ Add screens (same instances as Countdown mutates).
final class TimerStore {
    static let shared = TimerStore()
    var timers: [TimerModel] = []
    private init() {}
}
