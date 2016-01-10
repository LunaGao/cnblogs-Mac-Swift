//
//  BaseWebApi.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/16.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Foundation

class BaseWebApi : NSObject {

    func basicRequest(callback:(String?)->Void){
        let basicAuth = "Basic 这个值是根据ClientId和ClientSercret计算得来，这里隐藏"
        let urlstr = "https://api.cnblogs.com/token"
        let url = NSURL(string: urlstr)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.addValue(basicAuth, forHTTPHeaderField: "Authorization")
        let op:NSOperationQueue = NSOperationQueue.mainQueue()

        request.HTTPBody = "grant_type=client_credentials".dataUsingEncoding(NSUTF8StringEncoding)

        //通过NSURLConnection发送请求
        NSURLConnection.sendAsynchronousRequest(request, queue: op) {
            (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
            //异步处理
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                do {
                    let jsonValue: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)
                    if let statusesArray = jsonValue as? NSDictionary{
//                        NSLog("%@",statusesArray)
                        if let aStatus = statusesArray["access_token"] as? String{
                            callback(aStatus)
                        } else {
                            callback(nil)
                        }
                    }
                } catch {
                    callback(nil)
                }

//                NSLog("%@", String.init(data: data!, encoding: NSUTF8StringEncoding)!)
            })

        }
    }
}

//同步处理
//            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
//
//            })
