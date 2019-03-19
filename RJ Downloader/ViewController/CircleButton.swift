//
//  CircleButton.swift
//  RJ Downloader
//
//  Created by ImanX on 3/19/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa

class CircleButton: NSButton {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        
        self.layer?.cornerRadius = 0.5 * self.bounds.size.width
        
    }
    
}
