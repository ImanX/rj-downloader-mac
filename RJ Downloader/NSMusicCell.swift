//
//  NSMusicCell.swift
//  RJ Downloader
//
//  Created by ImanX on 3/18/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa

class NSMusicCell: NSTableCellView {

    @IBOutlet weak var lblAlbum: NSTextField!
    @IBOutlet weak var lblArtist: NSTextField!
    @IBOutlet weak var lblName: NSTextField!
    @IBOutlet weak var imgArtwork: NSImageView!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
    }
    

}
