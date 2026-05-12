// Project: ZouTianqing-HW5
// EID: tz4654
// Course: CS371L

import UIKit

protocol PizzaCreationDelegate: AnyObject {
    func didCreatePizza(_ pizza: Pizza)
}

class PizzaOrderViewController: UIViewController {
    
    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var summaryLabel: UILabel!
    
    weak var delegate: PizzaCreationDelegate?
    
    var selectedSize: String = "Small"
    var selectedCrust: String?
    var selectedCheese: String?
    var selectedMeat: String?
    var selectedVeggies: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // user shouldn't see anything now
        summaryLabel.text = ""
    }
    
    func showErrorAlert(missing: String) {
        // alert shown if the user leaves any ingredient unselected
        let controller = UIAlertController(title: "Missing ingredient", message: "Please select a \(missing) option.", preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK", style:
                .default))
        
        present(controller, animated: true)
    }
    
    @IBAction func sizeSelected(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex {
        case 0:
            selectedSize = "Small"
        case 1:
            selectedSize = "Medium"
        case 2:
            selectedSize = "Large"
        default:
            break
        }
    }
    
    @IBAction func selectCrust(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select crust",
            message: "Choose a crust type:",
            preferredStyle: .alert)
        
        // add action and save user's choice
        controller.addAction(UIAlertAction(title: "Thin crust", style: .default){_ in
            self.selectedCrust = "thin crust"
        })
        controller.addAction(UIAlertAction(title: "Thick crust", style: .default){_ in
            self.selectedCrust = "thick crust"
        })
        
        present(controller, animated: true)
    }
    
    
    @IBAction func selectCheese(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select cheese",
            message: "Choose a cheese type:",
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Regular cheese", style: .default){_ in
            self.selectedCheese = "regular cheese"
        })
        controller.addAction(UIAlertAction(title: "No cheese", style: .default){_ in
            self.selectedCheese = "no cheese"
        })
        controller.addAction(UIAlertAction(title: "Double cheese", style: .default){_ in
            self.selectedCheese = "double cheese"
        })
        
        present(controller, animated: true)
    }
    
    
    @IBAction func selectMeat(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select meat",
            message: "Choose one meat:",
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Pepperoni", style: .default){_ in
            self.selectedMeat = "pepperoni"
        })
        controller.addAction(UIAlertAction(title: "Sausage", style: .default){_ in
            self.selectedMeat = "sausage"
        })
        controller.addAction(UIAlertAction(title: "Canadian Bacon", style: .default){_ in
            self.selectedMeat = "canadian bacon"
        })
        
        present(controller, animated: true)
    }
    
    
    @IBAction func selectVeggies(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select veggies",
            message: "Choose your veggies:",
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Mushroom", style: .default){_ in
            self.selectedVeggies = "mushroom"
        })
        controller.addAction(UIAlertAction(title: "Onion", style: .default){_ in
            self.selectedVeggies = "onion"
        })
        controller.addAction(UIAlertAction(title: "Green Onion", style: .default){_ in
            self.selectedVeggies = "green onion"
        })
        controller.addAction(UIAlertAction(title: "Black Olive", style: .default){_ in
            self.selectedVeggies = "black olive"
        })
        controller.addAction(UIAlertAction(title: "None", style: .default){_ in
            self.selectedVeggies = "none"
        })
        
        present(controller, animated: true)
    }
    
    
    @IBAction func pressedDone(_ sender: Any) {
        
        // check anything missing
        if selectedCrust == nil {
            showErrorAlert(missing: "crust")
            return
        }

        if selectedCheese == nil {
            showErrorAlert(missing: "cheese")
            return
        }

        if selectedMeat == nil {
            showErrorAlert(missing: "meat")
            return
        }

        if selectedVeggies == nil {
            showErrorAlert(missing: "veggie")
            return
        }
        
        // save pizza
        let pizza = Pizza(
            size: selectedSize,
            crust: selectedCrust!,
            cheese: selectedCheese!,
            meat: selectedMeat!,
            veggies: selectedVeggies!
        )
        delegate?.didCreatePizza(pizza)
        
        // show summary label
        summaryLabel.text =
        """
        One \(selectedSize.lowercased()) pizza with:
            \(selectedCrust!)
            \(selectedCheese!)
            \(selectedMeat!)
            \(selectedVeggies!)
        """
    }
}
