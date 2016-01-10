//
//  MainWindowController.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/23.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa
import AppKit

class MainWindowController : NSWindowController , NSToolbarDelegate {
    
    let toolBarItemBlogs = "toolbarItemBlogs"
    let toolBarItemNews = "toolbarItemNews"
    var nowBarItem = ""
    
    var blogsViewController : BlogsListViewController?
    var newsViewController : NewsListViewController?
    
    @IBOutlet weak var mainToolbar: NSToolbar!
    
    override func windowDidLoad() {
        super.windowDidLoad()
//        self.window?.titleVisibility = .Hidden
        mainToolbar.delegate = self
        mainToolbar.selectedItemIdentifier = toolBarItemBlogs
        nowBarItem = toolBarItemBlogs
        
        blogsViewController = storyboard?.instantiateControllerWithIdentifier("BlogsListViewControllerId") as? BlogsListViewController
        newsViewController = storyboard?.instantiateControllerWithIdentifier("NewsListViewControllerId") as? NewsListViewController
        
        self.contentViewController = blogsViewController
    }
    
    @IBAction func clickBlogsButton(sender: AnyObject) {
        if nowBarItem == toolBarItemBlogs {
            blogsViewController!.reloadData()
            return
        } else {
            nowBarItem = toolBarItemBlogs
            self.contentViewController = blogsViewController
        }
    }
    
    @IBAction func clickNewsButton(sender: AnyObject) {
        if nowBarItem == toolBarItemNews {
            newsViewController!.reloadData()
            return
        } else {
            nowBarItem = toolBarItemNews
            self.contentViewController = newsViewController
        }
    }
}