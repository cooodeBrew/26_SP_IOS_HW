//
// Project: ZouTianqing-HW3
// EID: tz4654
// Course: CS371L
// 

import UIKit

class TextChangeVC: UIViewController {

    @IBOutlet weak var textChange: UITextField!
    
    var delegate: UIViewController!
    var vc1NewTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textChange.text = vc1NewTitle
    }
    
    @IBAction func textSavePress(_ sender: Any) {
        // passing new title to VC1
        guard let delegate = delegate as? TitleChanger else { return }
        let newTitle = textChange.text ?? ""
        delegate.changeTitle(newTitle: newTitle)
        navigationController?.popViewController(animated: true)
    }
}
