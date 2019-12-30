//
//  AddCommentViewController.swift
//  Hackathon
//
//  Created by Alperen Aysel on 29.12.2019.
//  Copyright © 2019 Alperen Aysel. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {
    @IBOutlet weak var commentField: UITextField!
    
    @IBOutlet weak var likeText: UILabel!
    
    var comment: EkleYorum?
    
    var id: String?
    var stars = 0
    
    var labelLike = ["Çok Kötü", "Kötü", "Orta", "İyi", "Çok İyi"]
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
    override func viewDidLoad() {
        super.viewDidLoad()

        commentField.borderStyle = UITextField.BorderStyle.roundedRect
        
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
    
    @IBAction func giveStar(_ sender: UISlider) {
        let myIntValue:Int = Int(sender.value)
        stars = myIntValue
        
        
        likeText.text = labelLike[myIntValue]
    }
    
    
    @IBAction func yorumEkle(_ sender: UIButton) {
        
        comment?.companyId = id!
        comment?.content = commentField.text!
        comment?.fullname =  "Alperen Can"
        comment?.star = stars
        
        User.bonus += 50
        
        showLoginAlert()
        
        
        
        
        
    }
    func showSimpleActionSheet() {
            let alert = UIAlertController(title: "Yorum Yapıldı", message: "50 MIPMONEY Hesabınıza Eklendi", preferredStyle: .alert)
         

            alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: { (_) in
            }))

            self.present(alert, animated: true, completion: {
            })
        }
    func showLoginAlert() {

    

    let alertController = UIAlertController(
        title: "Yorum Yapıldı",
        message: "50 MIPMONEY Hesabınıza Eklendi",
        preferredStyle: .alert)

    let loginAction = UIAlertAction(
    title: "Tamam", style: .default) {
        (action) -> Void in
        self.performSegue(withIdentifier: "backToMainVC", sender: nil)

      
    }
        alertController.addAction(loginAction)
               present(alertController, animated: true, completion: nil)
   
    }

}

