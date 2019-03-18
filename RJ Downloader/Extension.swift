//
//  Extension.swift
//  RJ Downloader
//
//  Created by ImanX on 3/17/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import Cocoa

extension NSButton{
    

    
}

extension StatusBarViewController {
    static func freshController(status:NSStatusItem) -> StatusBarViewController {
        let storyboard = NSStoryboard(name: "Main", bundle: nil);
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: "StatusBarViewController") as? StatusBarViewController else {
            fatalError("not find viewController");
        }
        viewcontroller.statusBar = status;
        return viewcontroller
    }
}


extension String {
    func matches(for regex: String) ->String {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            
            
            let res = results.map {
                String(self[Range($0.range, in: self)!])
            }
            
            return res.joined();
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return String();
        }
    }
    
    
}
