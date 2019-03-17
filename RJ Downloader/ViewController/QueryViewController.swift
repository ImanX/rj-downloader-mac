//
//  QueryViewController.swift
//  RJ Downloader
//
//  Created by ImanX on 3/17/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa

class QueryViewController: NSViewController {

    @IBOutlet weak var edtQuery: NSSearchField!
    @IBOutlet weak var btnDownload: NSButton!
    private var action:(()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func click(action:@escaping ()->Void) {
        self.action = action;
    }
    
    override func viewDidAppear() {
        recognizerClipboard();
      
    }
    
    @IBAction func clicked(_ sender: Any) {
        if let act = action{
            act();
        }
    }
    
    func recognizerClipboard() {
        
        let valueBoard =  NSPasteboard.general.pasteboardItems?.first?.string(forType: .string);
        
        guard let value = valueBoard else {
            return;
        }
        
        if let url = URL(string: value) , url.host == "www.radiojavan.com" {
                edtQuery.stringValue = url.absoluteString;
        }
        
    }
}
