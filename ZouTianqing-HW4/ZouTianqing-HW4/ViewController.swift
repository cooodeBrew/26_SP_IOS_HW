//
//  Project: ZouTianqing-HW4
//  EID: tz4654
//  Course: CD371L
//

import UIKit

let pipValue = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
let suit = ["Clubs", "Diamonds", "Hearts", "Spades"]

class ViewController: UIViewController, PipViewControllerDelegate, SuitViewControllerDelegate {
    
    @IBOutlet weak var generalLabel: UILabel!
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var pipLabel: UILabel!
    @IBOutlet weak var selectPipButton: UIButton!
    @IBOutlet weak var selectSuitButton: UIButton!
    
    var secretPipIndex: Int = 0
    var secretSuitIndex: Int = 0
    var guessCount: Int = 0
    var userPipIndex: Int?
    var userSuitIndex: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        // users don't need to see anything at the beginning
        generalLabel.text = ""
        suitLabel.text = ""
        pipLabel.text = ""

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pick random card
        secretPipIndex = Int.random(in: 0..<pipValue.count)
        secretSuitIndex = Int.random(in: 0..<suit.count)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pipSegueIdentifier",
           let pipVC = segue.destination as? PipViewController {
            pipVC.delegate = self
        }
        if segue.identifier == "suitSegueIdentifier",
           let suitVC = segue.destination as? SuitViewController {
            suitVC.delegate = self
            suitVC.pick = suit
        }
    }
    
    func suitViewController(_ controller: SuitViewController, didSelectSuit suitName: String) {
        selectSuitButton.setTitle(suitName, for: .normal)
        selectSuitButton.configuration?.title = suitName
        if let index = suit.firstIndex(of: suitName) {
            userSuitIndex = index
        }
    }
    
    func pipViewController(_ controller: PipViewController, didSelectPip index: Int) {
        userPipIndex = index
        let selectedPip = pipValue[index]
        selectPipButton.setTitle(selectedPip, for: .normal)
        selectPipButton.configuration?.title = selectedPip
    }
    
    @IBAction func pressSubmitButton(_ sender: Any) {
        
        // check any nil pip or suit
        guard let userPip = userPipIndex,
              let userSuit = userSuitIndex else {
            generalLabel.text = "Select a pip value and suit first"
            return
        }
        
        guessCount += 1
        
        // compare Pip value
        if userPip == secretPipIndex {
            pipLabel.text = "Correct pip value"
        } else if userPip < secretPipIndex {
            pipLabel.text = "Your pip value is too low"
        } else {
            pipLabel.text = "Your pip value is too high"
        }
        
        // compare Suit value
        if userSuit == secretSuitIndex {
                suitLabel.text = "Correct suit"
            } else {
                suitLabel.text = "Incorrect suit"
        }
        
        if userPip == secretPipIndex && userSuit == secretSuitIndex {
                generalLabel.text = "You guessed correctly in \(guessCount) tries!"
            } else {
                generalLabel.text = "Guesses so far: \(guessCount)"
        }
        
        
    }
}

