//
//  NSProgressView.swift
//  RJ Downloader
//
//  Created by ImanX on 3/16/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import Cocoa
class NSProgressView: NSBaseView{
    
    @IBOutlet weak var llblPercent: NSTextField!
    @IBOutlet weak var indicator: NSProgressIndicator!
    @IBOutlet var view: NSView!
    
    
    override func getXibName() -> String {
        return "XibProgressView";
    }
    
    override func getParentView() -> NSView? {
        return view;
    }

    
}




