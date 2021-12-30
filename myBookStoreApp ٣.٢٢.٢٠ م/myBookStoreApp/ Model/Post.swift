//
//  Post.swift
//  myBookStoreApp
//
//  Created by Dua'a ageel on 22/05/1443 AH.
//


import Foundation
import Firebase
struct Post {
    var id = ""
    var title = ""
    var description = ""
    var contact = ""
    var imageUrl = ""
    var user:User
    var createdAt:Timestamp?

   init(dict:[String:Any],id:String,user:User) {
        if let title = dict["title"] as? String,
          let description = dict["description"] as? String,
           let contact = dict["contact"] as? String,
         let imageUrl = dict["imageUrl"] as? String,
            let createdAt = dict["createdAt"] as? Timestamp{
            self.title = title
           self.description = description
            self.contact = contact
           self.imageUrl = imageUrl
           self.createdAt = createdAt
       }
        self.id = id
        self.user = user
  }
}
