// Project: ZouTianqing-HW5
// EID: tz4654
// Course: CS371L

import UIKit

class ViewController: UIViewController, PizzaCreationDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pizzaList: [Pizza] = []
    var pizzaCellIdentifier = "PizzaCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pizza Order"
        self.navigationItem.backButtonTitle = "Pizza Order"
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PizzaOrderViewController {
            vc.delegate = self
        }
    }

    func didCreatePizza(_ pizza: Pizza) {
        pizzaList.append(pizza)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pizzaCellIdentifier, for: indexPath)
        
        let pizza = pizzaList[indexPath.row]
        
        // unlimited lines
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text =
            """
            \(pizza.size.lowercased())
                \(pizza.crust.lowercased())
                \(pizza.cheese.lowercased())
                \(pizza.meat.lowercased())
                \(pizza.veggies.lowercased())
            """
        
        return cell
    }

}

