//
//  Project: ZouTianqing-HW4
//  EID: tz4654
//  Course: CD371L
//

import UIKit

let pipCellIdentifier = "PipCell"

protocol PipViewControllerDelegate: AnyObject {
    func pipViewController(_ controller: PipViewController, didSelectPip index: Int)
}

class PipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pipTableView: UITableView!
    
    weak var delegate: PipViewControllerDelegate?
    
    // hide the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pipTableView.delegate = self
        pipTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pipValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pipTableView.dequeueReusableCell(withIdentifier: pipCellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = pipValue[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.pipViewController(self, didSelectPip: indexPath.row)
        navigationController?.popViewController(animated: true)
    }
}
