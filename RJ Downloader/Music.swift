//
//  Music.swift
//  RJ Downloader
//
//  Created by ImanX on 3/17/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import Cocoa
class Music {
    
    
    init(file:URL) {
        self.file = file;
    }
    public var title:String?;
    public var artist:String?;
    public var album:String?;
    public var file:URL?;
    

    public var photo:NSImage?
}
