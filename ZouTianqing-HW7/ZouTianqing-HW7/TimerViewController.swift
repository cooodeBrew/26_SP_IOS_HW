// Project: ZouTianqing-HW7
// EID: tz4654
// Course: CS371L

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var EventFiled: UITextField!
    @IBOutlet weak var TimeField: UITextField!
    @IBOutlet weak var LocationField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        wireSaveButton()
    }

    private func wireSaveButton() {
        guard let saveButton = findSaveButton(in: view) else { return }
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    private func findSaveButton(in root: UIView) -> UIButton? {
        if let button = root as? UIButton {
            let title = button.configuration?.title ?? button.title(for: .normal)
            if title == "Save" { return button }
        }
        for sub in root.subviews {
            if let found = findSaveButton(in: sub) { return found }
        }
        return nil
    }

    @objc private func saveTapped() {
        view.endEditing(true)
        let event = EventFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let location = LocationField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let seconds = Int(TimeField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") ?? 0
        let model = TimerModel(event: event, location: location, remainingTime: max(0, seconds))
        TimerStore.shared.timers.append(model)
        navigationController?.popViewController(animated: true)
    }
}
