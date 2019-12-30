//
//  ProfileViewController.swift
//  Hackathon
//
//  Created by Alperen Aysel on 29.12.2019.
//  Copyright © 2019 Alperen Aysel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var money: UILabel!
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = User.name
        money.text = String(User.bonus)
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
    //        gradient
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
    

    @IBAction func AddFriend(_ sender: UIButton) {
        showLoginAlert()
    }
    
    func showLoginAlert() {

        var usernameTextField: UITextField?
        
        
       

        let alertController = UIAlertController(
            title: "Arkadaşına Öner",
            message: "50 MIPMONEY Kazanmak için Bir Arkadaşınızı Ekleyin.",
            preferredStyle: .alert)

        let loginAction = UIAlertAction(
        title: "Tamam", style: .default) {
            (action) -> Void in

            if (usernameTextField?.text) != nil {
                self.suAlert()
            }

        }
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel) { (_) in }


        alertController.addTextField {
            (txtUsername) -> Void in
            usernameTextField = txtUsername
            usernameTextField!.placeholder = "Arkadaşın Email'i"
        }


        alertController.addAction(cancelAction)
        alertController.addAction(loginAction)
        present(alertController, animated: true, completion: nil)

    }
    func suAlert() {

     

     let alertController = UIAlertController(
         title: "Arkadaş Önerildi",
         message: "50 MIPMONEY Hesabınıza Eklendi",
         preferredStyle: .alert)

     let loginAction = UIAlertAction(
     title: "Tamam", style: .default) {
         (action) -> Void in
        
        User.bonus += 50
        self.viewDidLoad()
         

       
     }
         alertController.addAction(loginAction)
                present(alertController, animated: true, completion: nil)
    
     }
    

}
