//
//  Globals.swift
//  Hackathon
//
//  Created by Alperen Aysel on 28.12.2019.
//  Copyright © 2019 Alperen Aysel. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct Company: Codable {
    let _id: String
    let name: String
    let sector: String
    let telNo: String
    let imagePath: String
    let fax: String
    let adress: String
    let website: String
    let nace: String
    let longitude: CLLocationDegrees
    let latitude: CLLocationDegrees
}

struct Comments: Codable {
    let fullname: String
    let star: Int
    let content: String
}
struct Posts: Codable {
    let _id: String
    let fullname: String
    let content: String
    let category: String
}

struct SubComments: Codable {
    let postid: String
    let fullname: String
    let content: String
    
}
//MARK: Switchlere bağla
struct Likes {
    static var ent = true
    static var job = true
    static var coms = true
    static var edu = true
}



class CustomCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var comment: UILabel!
}

class PostCell : UITableViewCell {
    
    @IBOutlet weak var pic: UIImageView!
    
    @IBOutlet weak var adi: UILabel!
    
    @IBOutlet weak var sektor: UILabel!
    
    
    @IBOutlet weak var postBody: UILabel!
    
}

class CommentCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var comment: UILabel!
}

class Duyurular: Codable {
    
    let imagePath: String
    let companyName: String
    let content: String
    let category: String
    
}


class Items: Codable {
    let _id: String
    let name: String
    let category: String
    let brand: String
    let model: String
    let price: Int
    let stock: Int
    let companyId: String
    
}

class BuyCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
}

class Preview: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var kategori: UILabel!
    
    
    @IBOutlet weak var content: UILabel!
}

struct Yorum: Codable {
    let companyId: String
    let fullname: String
    let star: Int
    let content: String
}

struct EkleYorum: Codable {
    var companyId: String
    var fullname: String
    var star: Int
    var content: String
}

struct User {
    static var name = String()
    static var bonus = 100
    static var email = String()
}

