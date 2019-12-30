//
//  ViewController.swift
//  Hackathon
//
//  Created by Alperen Aysel on 28.12.2019.
//  Copyright © 2019 Alperen Aysel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let gradient = CAGradientLayer()
       var gradientSet = [[CGColor]]()
       var currentGradient: Int = 0
       
       let colorOne = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
       let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
     override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

            createGradientView()
          
            
        }
        
        
        
        func createGradientView() {
            
            gradientSet.append([colorOne, colorTwo])

            
            // set the gradient size to be the entire screen
            gradient.frame = self.view.bounds
            gradient.colors = gradientSet[currentGradient]
            gradient.startPoint = CGPoint(x:0, y:0)
            gradient.endPoint = CGPoint(x:1, y:1)
            gradient.drawsAsynchronously = true
            
            self.view.layer.insertSublayer(gradient, at: 0)
            
            
        }

    @IBAction func job(_ sender: UISwitch) {
        if sender.isOn {
            Likes.job = true
        } else {
            Likes.job = false
        }
    }
    
    @IBAction func ent(_ sender: UISwitch) {
        if sender.isOn {
            Likes.ent = true
        } else {
            Likes.ent = false
        }
    }
    
    @IBAction func com(_ sender: UISwitch) {
        if sender.isOn {
            Likes.coms = true
        } else {
            Likes.coms = false
        }
    }
    @IBAction func edu(_ sender: UISwitch) {
        if sender.isOn {
            Likes.edu = true
        } else {
            Likes.edu = false
        }
    }
    
}

