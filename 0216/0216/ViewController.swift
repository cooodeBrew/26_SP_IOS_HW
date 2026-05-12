//
//  ViewController.swift
//  0216
//
//  Created by 阿清 on 2/16/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var UIlable: UILabel!
    @IBOutlet weak var segCr: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onSegChanged(_ sender: Any) {
        switch segCr.selectedSegmentIndex {
        case 0:
            UIlable.text = "First is selceted"
        case 1:
            UIlable.text = "Secodn is selceted"
        case 2:
            UIlable.text = "Third is selceted"
        case 3:
            UIlable.text = "Forth is selceted"
        default:
            UIlable.text = "Error: invalid selection"
        }
    }
    
}

