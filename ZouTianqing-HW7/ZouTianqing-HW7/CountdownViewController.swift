// Project: ZouTianqing-HW7
// EID: tz4654
// Course: CS371L


import UIKit

class CountdownViewController: UIViewController {

    @IBOutlet weak var EventLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var RemainingLabel: UILabel!

    var timerModel: TimerModel!

    private let countdownQueue = DispatchQueue(label: "com.zoutianqing.countdown")
    private var shouldStopCountdown = false
    private var isCountdownRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabelsFromModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard !isCountdownRunning else { return }
        isCountdownRunning = true
        shouldStopCountdown = false
        updateLabelsFromModel()
        startCountdownLoop()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shouldStopCountdown = true
        isCountdownRunning = false
    }

    private func updateLabelsFromModel() {
        EventLabel.text = timerModel.event
        LocationLabel.text = timerModel.location
        RemainingLabel.text = "\(timerModel.remainingTime)"
    }

    private func startCountdownLoop() {
        let model = timerModel!
        countdownQueue.async { [weak self] in
            while true {
                sleep(1)
                guard let self else { return }
                if self.shouldStopCountdown { break }
                if model.remainingTime <= 0 { break }
                model.remainingTime -= 1
                let display = model.remainingTime
                DispatchQueue.main.async {
                    self.RemainingLabel.text = "\(display)"
                }
            }
        }
    }
}
