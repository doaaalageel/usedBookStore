//
//  PostCell.swift
//  myBookStoreApp
//
//  Created by Dua'a ageel on 22/05/1443 AH.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postTitleLabel: UILabel!
    
    
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(with post:Post) -> UITableViewCell {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.description
        postImageView.loadImageUsingCache(with: post.imageUrl)
        userNameLabel.text = post.user.name
        userImageView.loadImageUsingCache(with: post.user.imageUrl)
        return self
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
        postImageView.image = nil
    }
}

    
    
//
//
//extension UIColor {
//
//   static func setColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
//        if #available(iOS 13, *) {
//            return UIColor{ (traitCollection) -> UIColor in
//                return traitCollection.userInterfaceStyle == .light ? lightColor : darkColor
//            }
//        } else {
//            return lightColor
//        }
//    }
//
//}
