//
//  PostTableViewCell.swift
//  ProductHuntPractice
//
//  Created by Rick Jacobson on 4/26/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    var post: Post? {
        didSet {
            // Make sure the post object exists
            guard let post = post else {return}
            
            // Update UI elements with post fields
            nameLabel.text = post.name
            taglineLabel.text = post.tagline
            commentsCountLabel.text = "Comments: \(post.commentsCount)"
            votesCountLabel.text = "Votes: \(post.votesCount)"
            
            updatePreviewImage()
        }
    }
    
    func updatePreviewImage() {
        guard let post = post else {return}
        previewImageView.image = UIImage(named: "placeholder")
    }
}
