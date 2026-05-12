//
// Project: ZouTianqing-HW3
// EID: tz4654
// Course: CS371L
// 

import UIKit

protocol TitleChanger {
    // to help change the VC 1's title
    func changeTitle(newTitle:String)
}

protocol ColorChanger {
    // to change the background color of the label
    // in main VC
    func changeColor(newColor:UIColor)
}

class ViewController: UIViewController, TitleChanger, ColorChanger {
    
    @IBOutlet weak var textTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "textChangeIdentifier",
           let nextVC = segue.destination as? TextChangeVC {
            nextVC.delegate = self
            nextVC.vc1NewTitle = textTitle.text ?? ""
        }
        
        if segue.identifier == "colorChangeIdentifier",
           let nextVC = segue.destination as? ColorChangeVC {
            nextVC.delegate = self
        }
        
    }
    
    func changeColor(newColor: UIColor) {
        textTitle.backgroundColor = newColor
    }
    
    func changeTitle(newTitle: String) {
        textTitle.text = newTitle
    }
}

