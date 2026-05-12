//
//  ViewController.swift
//  0206-TableView
//
//  Created by 阿清 on 2/18/26.
//

import UIKit

public let teams = [
    "Braves", "Marlins", "Phillies", "Mets", "Nationals",
    "Pirates", "Brewers", "Reds", "Cubs", "Cardinals",
    "Diamondbacks", "Dodgers", "Giants", "Padres", "Rockies",
    "Rays", "Orioles", "Yankees", "Blue Jays", "Red Sox",
    "Twins", "Guardians", "White Sox", "Tigers", "Royals",
    "Rangers", "Astros", "Angels", "Mariners", "Athletics"
    ]

public let cities = [
    "Atlanta", "Miami", "Philadelphia", "New York", "Washington",
    "Pittsburgh", "Milwaukee", "Cincinnati", "Chicago", "St. Louis",
    "Arizona", "Los Angeles", "San Francisco", "San Diego", "Colorado",
    "Tampa Bay", "Baltimore", "New York", "Toronto", "Boston",
    "Minnesota", "Cleveland", "Chicago", "Detroit", "Kansas City",
    "Texas", "Houston", "Los Angeles", "Seattle", "Oakland"
    ]

let textCelIdentifier = "TextCell"
let teamSegueIdentifier = "Segueidentifier"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCelIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = teams[indexPath.row]
        
        if indexPath.row < 15 {
            content.secondaryText = "National League"
        } else {
            content.secondaryText = "American League"
        }
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(teams[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.row == 17 ? nil : indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == teamSegueIdentifier,
           let destination = segue.destination as? TeamViewController,
           let teamIndex = tableView.indexPathForSelectedRow?.row {
            destination.teamName = teams[teamIndex]
        }
    }


}

