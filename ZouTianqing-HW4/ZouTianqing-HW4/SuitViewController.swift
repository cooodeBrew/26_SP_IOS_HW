//
//  Project: ZouTianqing-HW4
//  EID: tz4654
//  Course: CD371L
//

import UIKit

let suitCellIdentifier = "SuitCell"

protocol SuitViewControllerDelegate: AnyObject {
    func suitViewController(_ controller: SuitViewController, didSelectSuit suit: String)
}

class SuitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var SuitTableView: UITableView!
    
    weak var delegate: SuitViewControllerDelegate?
    var pick: [String] = []
    
    // hide the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SuitTableView.delegate = self
        SuitTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pick.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SuitTableView.dequeueReusableCell(withIdentifier: suitCellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = pick[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSuit = pick[indexPath.row]
        delegate?.suitViewController(self, didSelectSuit: selectedSuit)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.popViewController(animated: true)
    }
    



}
