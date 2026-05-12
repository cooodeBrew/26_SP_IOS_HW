//
//  ViewController.swift
//  segment
//
//  Created by 阿清 on 3/2/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var segCtrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onSegmentChanged(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex {
        case 0:
            textLabel.text = "First is selceted"
            performSegue(withIdentifier: "VC1", sender: self)
        case 1:
            textLabel.text = "Second is selected"
            performSegue(withIdentifier: "VC2", sender: self)
        case 2:
            textLabel.text = "Third is selected"
        case 3:
            textLabel.text = "Fourth is selected"
        default:
            textLabel.text = "Error"
        }
    }
}

