//
//  NSBaseView.swift
//  RJ Downloader
//
//  Created by ImanX on 3/17/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import Cocoa

class NSBaseView: NSView , IView{
    
    
    func getParentView() -> NSView? {
        return nil;
    }
    
    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect);
        loadNibFile();
        commit();
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder);
        loadNibFile();
        commit();
    }
    
    
    func getXibName() -> String {
        return className;
    }
    
    
    private func loadNibFile(){
        Bundle.main.loadNibNamed(getXibName(), owner: self, topLevelObjects: nil);
    }
    
    internal func commit(){
        let frame = NSMakeRect(0, 0, self.frame.width, self.frame.height);
        if let view = getParentView(){
            view.frame = frame;
            self.addSubview(view);
        }else{
            fatalError("Parent view is nil");
        }
        
    }
    
}


protocol IView {
    func getXibName()->String;
    func getParentView() -> NSView?;
}


