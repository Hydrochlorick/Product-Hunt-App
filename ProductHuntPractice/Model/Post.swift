//
//  Post.swift
//  ProductHuntPractice
//
//  Created by Rick Jacobson on 4/25/21.
//

import Foundation

struct Post {
    let id: Int
    let name: String
    let tagline: String
    let votesCount: Int
    let commentsCount: Int
    
    let previewImageURL: URL
}

struct PostList: Decodable {
    var posts: [Post]
}

extension Post: Decodable{
    enum PostKeys: String, CodingKey {
        // The variable names of the first three match the JSON object
        case id
        case name
        case tagline
        // These do not match, so they need to be mapped
        case votesCount = "votes_count"
        case commentsCount = "comments_count"
        case previewImageURL = "screenshot_url"
    }
    
    enum PreviewImageURLKeys: String, CodingKey {
        // "screenshot_url" contains multiple entries for different resolutions, but we only want the 850px one
        case imageURL = "850px"
    }
    
    // But there's more work to do
    init(from decoder: Decoder) throws {
        let postsContainer = try decoder.container(keyedBy: PostKeys.self)
        
        id = try postsContainer.decode(Int.self, forKey: .id)
        name = try postsContainer.decode(String.self, forKey: .name)
        tagline = try postsContainer.decode(String.self, forKey: .tagline)
        votesCount = try postsContainer.decode(Int.self, forKey: .votesCount)
        commentsCount = try postsContainer.decode(Int.self, forKey: .commentsCount)
        
        let URLNestedContainer = try postsContainer.nestedContainer(keyedBy: PreviewImageURLKeys.self, forKey: .previewImageURL)
        previewImageURL = try URLNestedContainer.decode(URL.self, forKey: .imageURL)
    }
}

struct Comment: Decodable {
    let id: Int
    let body: String
}

struct CommentApiResponse: Decodable {
    let comments: [Comment]
}
