//
//  CommentsViewController.swift
//  ProductHuntPractice
//
//  Created by Rick Jacobson on 4/27/21.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    var comments: [Comment]! {
        didSet {
            commentsTableView.reloadData()
        }
    }
    var postID: Int!
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        updateComments()
    }
    
    func updateComments() {
        networkManager.getComments(postID) { result in
            switch result {
            case let .success(comments):
                self.comments = comments
            case let .failure(error):
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        
        let comment = comments[indexPath.row]
        cell.commentTextView.text = comment.body
        return cell
    }
}
