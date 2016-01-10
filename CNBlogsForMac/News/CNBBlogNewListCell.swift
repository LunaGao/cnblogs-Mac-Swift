//
//  CNBBlogNewListCell.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/27.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa
import Alamofire

class CNBBlogNewListCell: NSTableCellView {
    
    @IBOutlet var TitleTextField: NSTextField!
    @IBOutlet var SummaryTextField: NSTextField!
    @IBOutlet var DateAddedTextField: NSTextField!
    @IBOutlet var ViewCountTextField: NSTextField!
    @IBOutlet var CommentCountTextField: NSTextField!
    @IBOutlet var DiggCountTextField: NSTextField!
    @IBOutlet weak var TopicIconImageView: NSImageView!

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    func setData(entity:NewsListEntity) {
        TitleTextField!.stringValue = entity.Title!
        SummaryTextField!.stringValue = entity.Summary!
        if entity.TopicIcon != nil {
            let escapedAddress = URLEncodedString(entity.TopicIcon!)
            Alamofire.request(.GET, escapedAddress!).response { (request, response, data, error) in
                if (error != nil) {
                    NSLog("%@", error!)
                } else {
                    self.TopicIconImageView.image = NSImage.init(data:data!)
                }
            }
        }
        DateAddedTextField!.stringValue = entity.DateAdded!.stringByReplacingOccurrencesOfString("T", withString: " ")
        ViewCountTextField!.stringValue = "阅读 \(entity.ViewCount!)"
        CommentCountTextField!.stringValue = "评论 \(entity.CommentCount!)"
        DiggCountTextField!.stringValue = "顶 \(entity.DiggCount!)"
    }
    
    func URLEncodedString(urlString:String) -> String? {
        let customAllowedSet =  NSCharacterSet(charactersInString:" ").invertedSet
        return urlString.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
    }
}
