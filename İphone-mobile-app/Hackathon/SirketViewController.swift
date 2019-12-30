//
//  SirketViewController.swift
//  Hackathon
//
//  Created by Alperen Aysel on 28.12.2019.
//  Copyright © 2019 Alperen Aysel. All rights reserved.
//

import UIKit

class SirketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var Buttons: [UIButton]!
    var companies = [Company]()

    @IBOutlet weak var tableView: UITableView!
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in Buttons {
            button.layer.cornerRadius = 27
        }
        
        downloadData {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self

        
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
           
           let cell = UITableViewCell()

           cell.textLabel?.text = companies[indexPath.row].name
           cell.textLabel?.numberOfLines = 0
        
           return cell
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return companies.count
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           performSegue(withIdentifier: "toStatsVC", sender: self)
       }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let nextVC = segue.destination as? StatsViewController
           nextVC?.currCompany = companies[tableView.indexPathForSelectedRow!.row]
       }
    
    
    func downloadData(compilation: @escaping () -> ()) {
           let url = "http://10.103.174.184:3000/companies/"
           let urlObject = URL(string: url)
           
           URLSession.shared.dataTask(with: urlObject!) {(data, response, error) in
               
        
               
               do {
                   self.companies = try JSONDecoder().decode([Company].self, from: data!)
            
            
                   DispatchQueue.main.async {
                       compilation()
                   }
               
               } catch {
                   print("JSON ERROR")
               }
               
           }.resume()
           
       }

}
