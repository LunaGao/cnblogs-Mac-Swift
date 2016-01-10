//
//  BlogsListViewController.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/24.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa

class BlogsListViewController: BaseViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var blogListTableView: NSTableView!
    
    var pageCount = 1;
    let pageSize = 20;
    let blogApi = BlogsWebApi()
    var blogList : [BlogsListEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blogList.removeAll()
        blogListTableView.backgroundColor = NSColor.clearColor()
        blogListTableView.setDelegate(self)
        blogListTableView.setDataSource(self)
        loadData()
    }
    
    func reloadData() {
        blogApi.blogsListRequest(1, pageSize: pageSize) { (jsonDictionary) -> Void in
            self.blogList.removeAll()
            for oneBlog in jsonDictionary {
                let entity = BlogsListEntity()
                entity.changeToEntity(oneBlog as! Dictionary<String, AnyObject>)
                self.blogList.append(entity)
            }
            self.pageCount = 1
            self.blogListTableView.scrollRowToVisible(0)
            self.blogListTableView.reloadData()
            self.isLoadingMore = false
            
            
            //            [self.tableView scrollToRowAtIndexPath:indexPath
            //                atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
    
    func loadData() {
        blogApi.blogsListRequest(pageCount, pageSize: pageSize) { (jsonDictionary) -> Void in
            for oneBlog in jsonDictionary {
                let entity = BlogsListEntity()
                entity.changeToEntity(oneBlog as! Dictionary<String, AnyObject>)
                self.blogList.append(entity)
            }
            self.blogListTableView.reloadData()
        }
    }
    
    var isLoadingMore = false
    func loadMore() {
        if !isLoadingMore {
            isLoadingMore = true
            pageCount++
            blogApi.blogsListRequest(pageCount, pageSize: pageSize) { (jsonDictionary) -> Void in
                for oneBlog in jsonDictionary {
                    let entity = BlogsListEntity()
                    entity.changeToEntity(oneBlog as! Dictionary<String, AnyObject>)
                    self.blogList.append(entity)
                }
                self.blogListTableView.reloadData()
                self.isLoadingMore = false
            }
        }
    }
    
    var prepareForSegueBlogId = 0
    var prepareForSegueBlogTitle = ""
    func tableView(tableView: NSTableView, selectionIndexesForProposedSelection proposedSelectionIndexes: NSIndexSet) -> NSIndexSet {
        let row = tableView.clickedRow
        if row >= 0 {
            prepareForSegueBlogId = blogList[row].BlogId!
            prepareForSegueBlogTitle = blogList[row].Title!
            performSegueWithIdentifier("BlogDetailSegue", sender: self)
        }
        return proposedSelectionIndexes
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return blogList.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeViewWithIdentifier("BlogListCell" , owner:self) as! CNBBlogListCell
        cellView.setData(blogList[row])
        return cellView
    }
    
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        if (pageCount * pageSize) - 4 < row {
            loadMore()
        }
        return nil
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 120
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BlogDetailSegue" {
            let theSegue = segue.destinationController as! BlogDetailViewController
            theSegue.blogId = prepareForSegueBlogId
            theSegue.blogTitle = prepareForSegueBlogTitle
        }
    }
}