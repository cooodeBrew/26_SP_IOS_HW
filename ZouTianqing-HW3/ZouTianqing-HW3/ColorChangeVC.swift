//
// Project: ZouTianqing-HW3
// EID: tz4654
// Course: CS371L
//

import UIKit

class ColorChangeVC: UIViewController {
    
    var delegate: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func redPress(_ sender: Any) {
        guard let otherVC = delegate as? ColorChanger else { return }
        otherVC.changeColor(newColor: UIColor.red)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func bluePress(_ sender: Any) {
        guard let otherVC = delegate as? ColorChanger else { return }
        otherVC.changeColor(newColor: UIColor.blue)
        navigationController?.popViewController(animated: true)
    }
}
