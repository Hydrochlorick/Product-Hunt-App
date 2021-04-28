//
//  FeedViewController.swift
//  ProductHuntPractice
//
//  Created by Rick Jacobson on 4/25/21.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    
    var networkManager = NetworkManager()
    var posts: [Post] = [] {
        didSet {
            feedTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
        
        updateFeed()
    }

    func updateFeed() {
        networkManager.getPosts() { result in
            // This is what we give to completion handler, which was given a list of posts as its parameter
            self.posts = result
        }
    }

}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        
        // This will run the didSet function
        cell.post = post
        return cell
    }
    
    
}
