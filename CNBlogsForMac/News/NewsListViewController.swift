//
//  NewsListViewController.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/24.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa

class NewsListViewController: BaseViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var newsListTableView: NSTableView!
    
    var pageCount = 1;
    let pageSize = 20;
    let newsApi = NewsWebApi()
    var newsList : [NewsListEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsList.removeAll()
        newsListTableView.backgroundColor = NSColor.clearColor()
        newsListTableView.setDelegate(self)
        newsListTableView.setDataSource(self)
        loadData()
    }
    
    var isreloadData = false
    func reloadData() {
        if !isreloadData {
            isreloadData = true
            newsApi.newsListRequest(1, pageSize: pageSize) { (jsonDictionary) -> Void in
                self.newsList.removeAll()
                for oneBlog in jsonDictionary {
                    let entity = NewsListEntity()
                    entity.changeToEntity(oneBlog as! Dictionary<String, AnyObject>)
                    self.newsList.append(entity)
                }
                self.pageCount = 1
                self.newsListTableView.scrollRowToVisible(0)
                self.newsListTableView.reloadData()
                self.isLoadingMore = false
                self.isreloadData = false
                
                //            [self.tableView scrollToRowAtIndexPath:indexPath
                //                atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        }
    }
    
    func loadData() {
        newsApi.newsListRequest(pageCount, pageSize: pageSize) { (jsonDictionary) -> Void in
            for oneBlog in jsonDictionary {
                let entity = NewsListEntity()
                entity.changeToEntity(oneBlog as! Dictionary<String, AnyObject>)
                self.newsList.append(entity)
            }
            self.newsListTableView.reloadData()
        }
    }
    
    var isLoadingMore = false
    func loadMore() {
        if !isLoadingMore {
            isLoadingMore = true
            pageCount++
            newsApi.newsListRequest(pageCount, pageSize: pageSize) { (jsonDictionary) -> Void in
                for oneBlog in jsonDictionary {
                    let entity = NewsListEntity()
                    entity.changeToEntity(oneBlog as! Dictionary<String, AnyObject>)
                    self.newsList.append(entity)
                }
                self.newsListTableView.reloadData()
                self.isLoadingMore = false
            }
        }
    }
    
    var prepareForSegueNewsId = 0
    var prepareForSegueNewsTitle = ""
    func tableView(tableView: NSTableView, selectionIndexesForProposedSelection proposedSelectionIndexes: NSIndexSet) -> NSIndexSet {
        let row = tableView.clickedRow
        if row >= 0 {
            prepareForSegueNewsId = newsList[row].NewsId!
            prepareForSegueNewsTitle = newsList[row].Title!
            performSegueWithIdentifier("NewsDetailSegue", sender: self)
        }
        return proposedSelectionIndexes
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return newsList.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeViewWithIdentifier("NewsListCell" , owner:self) as! CNBBlogNewListCell
        cellView.setData(newsList[row])
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
        if segue.identifier == "NewsDetailSegue" {
            let theSegue = segue.destinationController as! NewsDetailViewController
            theSegue.newsId = prepareForSegueNewsId
            theSegue.newsTitle = prepareForSegueNewsTitle
        }
    }
}