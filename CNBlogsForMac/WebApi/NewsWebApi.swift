//
//  NewsWebApi.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/26.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Foundation

class NewsWebApi: NSObject {
    
    func newsListRequest(pageIndex:Int , pageSize:Int, callback:(NSArray) -> Void){
        let baseApi = BaseWebApi()
        baseApi.basicRequest { (access_token) -> Void in
            if access_token == nil {
                // 获取验证码错误，或者网络异常等，这里需要直接处理返回
            }
            let basicAuth = "Bearer " + access_token!
            let urlstr = "https://api.cnblogs.com/api/NewsItems?pageIndex=\(pageIndex)&pageSize=\(pageSize)"
            let url = NSURL(string: urlstr)
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
            request.addValue(basicAuth, forHTTPHeaderField: "Authorization")
            let op:NSOperationQueue = NSOperationQueue.mainQueue()
            //通过NSURLConnection发送请求
            NSURLConnection.sendAsynchronousRequest(request, queue: op) {
                (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
                //异步处理
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    NSLog("%@", String.init(data: data!, encoding: NSUTF8StringEncoding)!)
                    do {
                        let jsonValue: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)
                        if let statusesArray = jsonValue as? NSArray{
                            callback(statusesArray)
                        }
                    } catch {
                        
                    }
                })
            }
        }
    }
    
    func newsBodyRequest(newsId:Int , callback:(NSData) -> Void){
        let baseApi = BaseWebApi()
        baseApi.basicRequest { (access_token) -> Void in
            if access_token == nil {
                // 获取验证码错误，或者网络异常等，这里需要直接处理返回
            }
            let basicAuth = "Bearer " + access_token!
            let urlstr = "https://api.cnblogs.com/api/newsitems/\(newsId)/body"
            let url = NSURL(string: urlstr)
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
            request.addValue(basicAuth, forHTTPHeaderField: "Authorization")
            let op:NSOperationQueue = NSOperationQueue.mainQueue()
            //通过NSURLConnection发送请求
            NSURLConnection.sendAsynchronousRequest(request, queue: op) {
                (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
                //异步处理
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //                    NSLog("%@", String.init(data: data!, encoding: NSUTF8StringEncoding)!)
                    //                        callback(String.init(data: data!, encoding: NSUnicodeStringEncoding)!)
                    callback(data!)
                })
            }
        }
    }
}

//同步处理
//            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
//
//            })
