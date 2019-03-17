//
//  ProgressViewController.swift
//  RJ Downloader
//
//  Created by ImanX on 3/17/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa

class ProgressViewController: NSViewController {

    @IBOutlet weak var lblPercents: NSTextField!
    @IBOutlet weak var progress: NSProgressIndicator!
    override func viewDidLoad() {
        super.viewDidLoad()
        progress.startAnimation(nil);
    }
    
}
