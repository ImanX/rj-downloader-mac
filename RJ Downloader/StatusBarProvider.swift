//
//  StatusBarProvider.swift
//  RJ Downloader
//
//  Created by ImanX on 3/15/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import Cocoa
class StatusBarProvider {
    
    private let statusBar:NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength);
    private let popover = NSPopover();

    
    func create() {
        statusBar.button?.image = NSImage.init(named: NSImage.Name("ic_statubar"));
        statusBar.button?.action = #selector(openPopover);
        popover.contentViewController = StatusBarViewController.freshController();
    }
    
    

    
    
    @objc private func openPopover(){
        if popover.isShown {
            popover.close();
        }else {
            popover.show(relativeTo: (statusBar.button?.bounds)!, of: statusBar.button!, preferredEdge: NSRectEdge.minY);
        }
    }
    
    
    
    

}
