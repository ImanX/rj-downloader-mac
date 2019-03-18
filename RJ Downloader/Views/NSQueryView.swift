//
//  NSQueryView.swift
//  RJ Downloader
//
//  Created by ImanX on 3/17/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import Cocoa
class NSQueryView: NSBaseView {
    @IBOutlet var view: NSView!
    @IBOutlet weak var btnDownload: NSButton!
    @IBOutlet weak var edtQuery: NSSearchFieldCell!
    override func getXibName() -> String {
        return "XibQueryView"
    }
    
    
    override func getParentView() -> NSView? {
        return view;
    }
    
    
    @IBAction func clicked(_ sender: Any) {
    }
}
