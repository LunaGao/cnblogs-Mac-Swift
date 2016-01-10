//
//  NewsListEntity.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/26.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa

class NewsListEntity: NSObject {
    
    var NewsId : Int?
    var Title : String?
    var Summary : String?
    var TopicId : Int?
    var TopicIcon : String?
    var ViewCount : Int?
    var CommentCount : Int?
    var DiggCount : Int?
    var DateAdded : String?
    
    required override init() {
    }
    
    func changeToEntity(oneBlog:Dictionary<String, AnyObject>){
        if let blogId = oneBlog["Id"] as? Int {
            self.NewsId = blogId
        }
        if let title = oneBlog["Title"] as? String {
            self.Title = title
        }
        if let summary = oneBlog["Summary"] as? String {
            self.Summary = summary
        }
        if let topicId = oneBlog["TopicId"] as? Int {
            self.TopicId = topicId
        }
        if let topicIcon = oneBlog["TopicIcon"] as? String {
            self.TopicIcon = topicIcon
        }
        if let dateAdded = oneBlog["DateAdded"] as? String {
            self.DateAdded = dateAdded
        }
        if let viewCount = oneBlog["ViewCount"] as? Int {
            self.ViewCount = viewCount
        }
        if let commentCount = oneBlog["CommentCount"] as? Int {
            self.CommentCount = commentCount
        }
        if let diggCount = oneBlog["DiggCount"] as? Int {
            self.DiggCount = diggCount
        }
    }
    
}
