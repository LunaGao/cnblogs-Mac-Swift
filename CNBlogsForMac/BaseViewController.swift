//
//  BaseViewController.swift
//  CNBlogsForMac
//
//  Created by Luna Gao on 15/11/24.
//  Copyright © 2015年 gao.luna.com. All rights reserved.
//

import Cocoa

class BaseViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as? NSVisualEffectView {
            // Make view translucent
            view.blendingMode = .BehindWindow
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}