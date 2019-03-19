//
//  AboutViewController.swift
//  RJ Downloader
//
//  Created by ImanX on 3/19/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa

class AboutViewController: NSViewController {
    @IBOutlet weak var lblVersion: NSTextField!
    
  
    
    override func viewDidAppear() {
        view.window!.styleMask.remove(.resizable)

    }
    @IBAction func click(_ sender: Any) {
        let url = URL(string: "https://www.twitter.com/ImanX77");
        NSWorkspace.shared.open(url!);

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            lblVersion.stringValue = "Version \(ver)"
        }
    }
    
}
