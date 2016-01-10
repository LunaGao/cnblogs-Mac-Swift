//
//  NewsDetailViewController.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/12/2.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa
import WebKit

class NewsDetailViewController: BaseViewController {
    
    @IBOutlet weak var detailNewsWebView: WebView!
    
    var newsId = 0;
    var newsTitle = "";
    let newsApi = NewsWebApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = newsTitle
    }
    
    override func viewDidAppear() {
        newsApi.newsBodyRequest(newsId) { (response) -> Void in
            var localHtmlString = NSString.init(data: response, encoding: NSUTF8StringEncoding)!
            localHtmlString = localHtmlString.substringToIndex(localHtmlString.length - 1)
            localHtmlString = localHtmlString.substringFromIndex(1)
            localHtmlString = self.transferredString(localHtmlString as String)
            //            NSLog("%@", localHtmlString)
            self.detailNewsWebView.mainFrame.loadHTMLString(localHtmlString as String, baseURL: nil)
            //            self.detailBlogWebView.mainFrame.loadData(response, MIMEType: "text/html", textEncodingName: "utf-8", baseURL: nil)
        }
    }
    
    func transferredString(var string:String) -> String {
        string = string.stringByReplacingOccurrencesOfString("\\\"", withString: "\"")
        string = string.stringByReplacingOccurrencesOfString("\\r\\n", withString: "\n")
        string = string.stringByReplacingOccurrencesOfString("\\t", withString: "\t")
        string = string.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
        // 基本样式
        string = string + "<link type=\"text/css\" rel=\"stylesheet\" href=\"http://www.cnblogs.com/bundles/news.css\"/>"
        // 有代码段时用来收起和展示的js
        string = string + "<script src=\"http://www.cnblogs.com/bundles/news.js\" type=\"text/javascript\"></script>"
        string = string + "<script src=\"http://common.cnblogs.com/script/jquery.js\" type=\"text/javascript\"></script>"
        return string
    }
}
