//
//  BlogsListEntity.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/26.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa

class BlogsListEntity: NSObject {

    var BlogId : Int?
    var Title : String?
    var Url : String?
    var Description : String?
    var Author : String?
    var BlogApp : String?
    var Avatar : String?
    var PostDate : String?
    var ViewCount : Int?
    var CommentCount : Int?
    var DiggCount : Int?
    
    required override init() {
    }

    func changeToEntity(oneBlog:Dictionary<String, AnyObject>){
        if let blogId = oneBlog["Id"] as? Int {
            self.BlogId = blogId
        }
        if let title = oneBlog["Title"] as? String {
            self.Title = title
        }
        if let url = oneBlog["Url"] as? String {
            self.Url = url
        }
        if let description = oneBlog["Description"] as? String {
            self.Description = description
        }
        if let author = oneBlog["Author"] as? String {
            self.Author = author
        }
        if let blogApp = oneBlog["BlogApp"] as? String {
            self.BlogApp = blogApp
        }
        if let avatar = oneBlog["Avatar"] as? String {
            self.Avatar = avatar
        }
        if let postDate = oneBlog["PostDate"] as? String {
            self.PostDate = postDate
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
//        return self
    }
}
