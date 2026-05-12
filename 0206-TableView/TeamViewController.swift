//
//  TeamViewController.swift
//  0206-TableView
//
//  Created by 阿清 on 2/18/26.
//

import UIKit

class TeamViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    
    var teamName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamLabel.text = "Team selected: \(teamName)"
        // search the arry and return the first index of that name
        let teamIndex = teams.firstIndex(of: teamName)
        cityLabel.text = "City: \(cities[teamIndex!])"
    }

}
