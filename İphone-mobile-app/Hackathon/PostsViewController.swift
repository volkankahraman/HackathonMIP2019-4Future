//
//  PostsViewController.swift
//  Hackathon
//
//  Created by Alperen Aysel on 28.12.2019.
//  Copyright © 2019 Alperen Aysel. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var Buttons: [UIButton]!
    var ourPods = [Posts]()
    
    var insterestedPost = [Posts]()

    
    var ourLikes = [String]()
    var howMany = 0
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in Buttons {
            button.layer.cornerRadius = 27
        }

        downloadData {
            self.tableView.reloadData()
        }
        if Likes.edu {
            ourLikes.append("Eğitim")
        }
        if Likes.coms {
            ourLikes.append("İletişim")
        }
        if Likes.ent {
            ourLikes.append("Eğlence")
        }
        if Likes.job {
            ourLikes.append("İş")
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
               
          let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostCell
        
        
        cell.adi.text = insterestedPost[indexPath.row].fullname
        cell.sektor.text = insterestedPost[indexPath.row].category
        cell.postBody.text = insterestedPost[indexPath.row].content
        cell.postBody.numberOfLines = 0
        
                    

          return cell
           }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return insterestedPost.count
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toCommentsVC", sender: self)
            
        }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
     }

     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let nextVC = segue.destination as? CommentsViewController
        nextVC?.id = ourPods[tableView.indexPathForSelectedRow!.row]._id
           
       }

    func downloadData(compilation: @escaping () -> ()) {
        let url = "http://10.103.174.184:3000/posts/"
        print(url)
        let urlObject = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObject!) {(data, response, error) in
        
            do {
                self.ourPods = try JSONDecoder().decode([Posts].self, from: data!)
                
                for post in self.ourPods {
                    if self.ourLikes.firstIndex(of: post.category) != nil {
                        self.insterestedPost.append(post)
                        
                    }
                }
         
         
                DispatchQueue.main.async {
                    compilation()
                }
            
            } catch {
                print("JSON ERROR")
            }
            
        }.resume()
        
    }
}
