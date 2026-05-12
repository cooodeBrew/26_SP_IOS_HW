// Project: ZouTianqing-HW7
// EID: tz4654
// Course: CS371L

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private var timers: [TimerModel] { TimerStore.shared.timers }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Timer"
        navigationItem.backButtonTitle = "Timer"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath)
        cell.layoutIfNeeded()
        let model = timers[indexPath.row]
        configureTimerCell(cell, with: model)
        return cell
    }

    private func configureTimerCell(_ cell: UITableViewCell, with model: TimerModel) {
        guard let eventTitleLabel = cell.contentView.viewWithTag(1) as? UILabel,
              let locationTitleLabel = cell.contentView.viewWithTag(2) as? UILabel,
              let eventValueLabel = cell.contentView.viewWithTag(3) as? UILabel,
              let locationValueLabel = cell.contentView.viewWithTag(4) as? UILabel,
              let remainingTimeLabel = cell.contentView.viewWithTag(5) as? UILabel else { return }
        eventTitleLabel.text = "Event"
        locationTitleLabel.text = "Location"
        eventValueLabel.text = model.event
        locationValueLabel.text = model.location
        remainingTimeLabel.text = "Remaining Time(s) \(model.remainingTime)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let countdownVC = segue.destination as? CountdownViewController,
              let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        countdownVC.timerModel = timers[indexPath.row]
    }
}
