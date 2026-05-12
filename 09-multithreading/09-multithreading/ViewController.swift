//
//  ViewController.swift
//  09-multithreading
//
//  Created by 阿清 on 3/29/26.
//

import UIKit

class ViewController: UIViewController {
    
    private var queue: DispatchQueue!
    
    var dot: UIView!
    var xLeft: Double!
    var xRight: Double!
    var y: Double!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dotHeight = 100.0
        let dotWidth = 100.0
        
        xLeft = dotWidth/2.0
        xRight = view.bounds.width - (1.5 * dotWidth)
        y = (view.bounds.height / 2.0) - (dotHeight / 2.0)
        
        dot = UIView(frame: CGRect(x: xLeft, y: y, width: dotWidth, height: dotHeight))
        dot.backgroundColor = .red
        
        dot.layer.cornerRadius = dotWidth/2.0
        
        view.addSubview(dot)
        
        queue = DispatchQueue(label: "myQueue", qos:.utility)
        
        queue.async {
            self.moveBlock()
        }
        
        
    }
    
    func moveBlock() {
        
        var toggle = "left"
        
        while true {
            usleep(3000000) //0.3 sec
            
            if toggle == "left" {
                toggle = "right"
                
                DispatchQueue.main.async {
                    self.dot.frame.origin.x = self.xRight
                }
                
            } else {
                toggle = "left"
                
                DispatchQueue.main.async {
                    self.dot.frame.origin.x = self.xLeft
                }
                
            }
        }
    }


}

