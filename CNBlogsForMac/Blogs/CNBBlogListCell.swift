//
//  CNBBlogListCell.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/25.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa
import Alamofire

class CNBBlogListCell: NSTableCellView {
    
    @IBOutlet var TitleTextField: NSTextField!
    @IBOutlet var DescriptionTextField: NSTextField!
    @IBOutlet var PostDateTextField: NSTextField!
    @IBOutlet var ViewCountTextField: NSTextField!
    @IBOutlet var CommentCountTextField: NSTextField!
    @IBOutlet var DiggCountTextField: NSTextField!
    @IBOutlet weak var AuthorTextField: NSTextField!
    @IBOutlet weak var UserHeaderImageView: NSImageView!

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    func setData(entity:BlogsListEntity) {
        TitleTextField!.stringValue = entity.Title!
        DescriptionTextField!.stringValue = entity.Description!
        AuthorTextField!.stringValue = entity.Author!
        if entity.Avatar != nil {
            let escapedAddress = URLEncodedString(entity.Avatar!)
            Alamofire.request(.GET, escapedAddress!).response { (request, response, data, error) in
                if (error != nil) {
                    NSLog("%@", error!)
                } else {
                    self.UserHeaderImageView.image = NSImage.init(data:data!)
                }
            }
        }
        PostDateTextField!.stringValue = entity.PostDate!.stringByReplacingOccurrencesOfString("T", withString: " ")
        ViewCountTextField!.stringValue = "阅读 \(entity.ViewCount!)"
        CommentCountTextField!.stringValue = "评论 \(entity.CommentCount!)"
        DiggCountTextField!.stringValue = "顶 \(entity.DiggCount!)"
    }
    
    
    func URLEncodedString(urlString:String) -> String? {
        let customAllowedSet =  NSCharacterSet(charactersInString:" ").invertedSet
        return urlString.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
    }
}
