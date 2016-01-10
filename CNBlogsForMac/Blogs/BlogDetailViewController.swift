//
//  BlogDetailViewController.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/12/1.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa
import WebKit

class BlogDetailViewController: BaseViewController {
    
    @IBOutlet weak var detailBlogWebView: WebView!
    
    var blogId = 0;
    var blogTitle = ""
    let blogApi = BlogsWebApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = blogTitle
    }
    
    override func viewDidAppear() {
        blogApi.blogBodyRequest(blogId) { (response) -> Void in
            var localHtmlString = NSString.init(data: response, encoding: NSUTF8StringEncoding)!
            localHtmlString = localHtmlString.substringToIndex(localHtmlString.length - 1)
            localHtmlString = localHtmlString.substringFromIndex(1)
            localHtmlString = self.transferredString(localHtmlString as String)
//            NSLog("%@", localHtmlString)
            self.detailBlogWebView.mainFrame.loadHTMLString(localHtmlString as String, baseURL: nil)
//            self.detailBlogWebView.mainFrame.loadData(response, MIMEType: "text/html", textEncodingName: "utf-8", baseURL: nil)
        }
    }
    
    func transferredString(var string:String) -> String {
        string = string.stringByReplacingOccurrencesOfString("\\\"", withString: "\"")
        string = string.stringByReplacingOccurrencesOfString("\\r\\n", withString: "\n")
        string = string.stringByReplacingOccurrencesOfString("\\t", withString: "\t")
        string = string.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
        // 基本样式
        string = string + "<link type=\"text/css\" rel=\"stylesheet\" href=\"http://www.cnblogs.com/bundles/blog-common.css\"/>"
        // 有代码段时用来收起和展示的js
        string = string + "<script src=\"http://www.cnblogs.com/bundles/blog-common.js\" type=\"text/javascript\"></script>"
        string = string + "<script src=\"http://common.cnblogs.com/script/jquery.js\" type=\"text/javascript\"></script>"
        string = "<body style=\"background-color: transparent\">" + string + "</body>"
        return string
    }
}
