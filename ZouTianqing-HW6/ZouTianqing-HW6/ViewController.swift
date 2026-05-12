// Project: ZouTianqing-HW5
// EID: tz4654
// Course: CS371L

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController, PizzaCreationDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pizzaList: [Pizza] = []
    var pizzaCellIdentifier = "PizzaCell"
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pizza Order"
        self.navigationItem.backButtonTitle = "Pizza Order"

        // Sign-out button to return to the login screen.
        // Put it on the left so the storyboard's "+" add button on the right stays.
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .plain,
            target: self,
            action: #selector(signOutTapped)
        )
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    @objc private func signOutTapped() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Sign out error: \(error)")
        }

        // LoginViewController is presented fullscreen; dismissing returns to it.
        dismiss(animated: true)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllPizzasAndReload()
    }

    // Fetch all pizzas from Firestore and load into `pizzaList` (table view source).
    func fetchAllPizzasAndReload() {
        db.collection("pizza").getDocuments { [weak self] snapshot, error in
            guard let self else { return }
            if let error = error {
                print("Error fetching pizzas: \(error)")
                return
            }
            guard let snapshot else { return }

            var loaded: [Pizza] = []
            for doc in snapshot.documents {
                let data = doc.data()
                guard
                    let size = data["size"] as? String,
                    let crust = data["crust"] as? String,
                    let cheese = data["cheese"] as? String,
                    let meat = data["meat"] as? String,
                    let veggies = data["veggies"] as? String
                else {
                    continue
                }
                let pizza = Pizza(
                    size: size,
                    crust: crust,
                    cheese: cheese,
                    meat: meat,
                    veggies: veggies,
                    documentID: doc.documentID
                )
                loaded.append(pizza)
            }

            DispatchQueue.main.async {
                self.pizzaList = loaded
                self.tableView.reloadData()
            }
        }
    }

    // Swipe-to-delete (and delete in Firestore too).
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let pizza = pizzaList[indexPath.row]
        pizzaList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)

        guard let documentID = pizza.documentID else {
            // If this pizza came from local UI but has no doc id, we can't delete from Firestore.
            return
        }

        db.collection("pizza").document(documentID).delete { error in
            if let error = error {
                print("Error deleting pizza \(documentID): \(error)")
            }
        }
    }

}

