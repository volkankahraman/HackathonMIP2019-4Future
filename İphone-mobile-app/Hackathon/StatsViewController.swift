//
//  StatsViewController.swift
//  Hackathon
//
//  Created by Alperen Aysel on 28.12.2019.
//  Copyright © 2019 Alperen Aysel. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var currCompany: Company?

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var sector: UILabel!
    
    @IBOutlet weak var adress: UILabel!
    
    @IBOutlet weak var telno: UILabel!
    
    @IBOutlet weak var comments: UITableView!
    
    var commentsArray = [Comments]()
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData {
            self.comments.reloadData()
        }
        
        comments.delegate = self
        comments.dataSource = self
               
        name.numberOfLines = 0
        sector.numberOfLines = 0
        adress.numberOfLines = 0

        name.text = currCompany?.name
        sector.text = currCompany?.sector
        adress.text = currCompany?.adress
        telno.text = currCompany?.telNo
        
        
        let url = URL(string: currCompany!.imagePath)

       DispatchQueue.global().async {
           let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
           DispatchQueue.main.async {
            self.image.image = UIImage(data: data!)
           }
       }
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
        let cell = comments.dequeueReusableCell(withIdentifier: "testCell") as! CustomCell

        cell.name.text = commentsArray[indexPath.row].fullname
        cell.comment.text = commentsArray[indexPath.row].content
        cell.comment.numberOfLines = 0
        
        

        return cell
         }

         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return commentsArray.count
         }
         
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             
         }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 100
      }

      func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
          return UITableView.automaticDimension
      }
    

    @IBAction func map(_ sender: UIButton) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapVC" {
            let nextVC = segue.destination as? MapViewController
            nextVC?.currComp = currCompany
        }
        
        if segue.identifier == "toAlisverisVC" {
            let next = segue.destination as? AlisverisViewController
            next?.id = currCompany?._id
        }
        
    }
    func downloadData(compilation: @escaping () -> ()) {
        let comID = currCompany!._id
        let url = "http://10.103.174.184:3000/comments/company/\(comID)"
        print(url)
        let urlObject = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObject!) {(data, response, error) in
        
            do {
                self.commentsArray = try JSONDecoder().decode([Comments].self, from: data!)
         
         
                DispatchQueue.main.async {
                    compilation()
                }
            
            } catch {
                print("JSON ERROR")
            }
            
        }.resume()
        
    }
    
    @IBAction func ListItems(_ sender: UIButton) {
        performSegue(withIdentifier: "toAlisverisVC", sender: nil)
    }
    
}
