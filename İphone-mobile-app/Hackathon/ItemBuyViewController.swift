//
//  ItemBuyViewController.swift
//  Hackathon
//
//  Created by Alperen Aysel on 29.12.2019.
//  Copyright © 2019 Alperen Aysel. All rights reserved.
//

import UIKit

class ItemBuyViewController: UIViewController {
    
    var currentItem: Items?

    @IBOutlet weak var itemName: UILabel!
    
    
    @IBOutlet weak var itemCate: UILabel!
    
    
    @IBOutlet weak var itemBrand: UILabel!
    
    
    @IBOutlet weak var itemModel: UILabel!
    
    
    
    @IBOutlet weak var itemPrice: UILabel!
    
    
    @IBOutlet weak var itemStock: UILabel!
    
    @IBOutlet weak var howMany: UITextField!
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        itemName.text = currentItem?.name
        itemCate.text = currentItem?.category
        itemBrand.text = currentItem?.brand
        itemModel.text = currentItem?.model
        itemPrice.text = String(currentItem!.price)
        itemStock.text = String(currentItem!.stock)
        
        

        
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
    

    
    @IBAction func Buy(_ sender: UIButton) {
        
        let many = Int(howMany.text!)
//        currentItem?.amount = many!
        
        if many! > (currentItem?.stock)! {
            showSimpleActionSheet()
        } else {
            do {
                let urlPart = currentItem?._id
                     let url = URL(string: "http://10.103.174.184:3000/products/\(urlPart!)/sell")!
                      var request = URLRequest(url: url)

                      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                      request.httpMethod = "POST"
                      request.httpBody = try JSONEncoder().encode(currentItem!)
                      
                      
                      let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                          guard let data = data, error == nil else {
                          // check for fundamental networking error
                          print("fundamental networking error=\(error)")
                          return
                          }

                          if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                          // check for http errors
                          print("statusCode should be 200, but is \(httpStatus.statusCode)")
                          print("response = \(response)")
                          }

                          let responseString = String(data: data, encoding: .utf8)
                          print("responseString = \(responseString)")
                      }
                      dataTask.resume()
                      
                      
                      
                      
                  } catch {
                      print(error.localizedDescription)
                  }
            performSegue(withIdentifier: "toYorumVC", sender: nil)

        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddCommentViewController
        nextVC.id = currentItem?.companyId
    }
    func showSimpleActionSheet() {
          let alert = UIAlertController(title: "Satın Alınamadı", message: "Ürün stokta yeteri kadar yok", preferredStyle: .alert)
       

          alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: { (_) in
          }))

          self.present(alert, animated: true, completion: {
          })
      }
    
}
