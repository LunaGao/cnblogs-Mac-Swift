//
//  LGWebImage.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/12/1.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa

class LGWebImage: NSObject {

    static func loadImageInImageView(imageView:NSImageView,url:String) {
        let imageURL = NSURL(string:url)
        let imageData = NSData(contentsOfURL:imageURL!)
        if imageData != nil {
            let newImage = NSImage.init(data:imageData!)
            imageView.image = newImage
        }
    }    
}
