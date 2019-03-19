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
    internal var delegate:QueryViewControllerDelegate!;
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
    override func viewDidAppear() {
        recognizerClipboard();
      
    }
    
    @IBAction func clicked(_ sender: Any) {
        self.delegate.didDownloadClick(sender: sender as! NSButton);
        startDownload();
        
    }
    
    func startDownload() {
         
        
        let value = self.edtQuery.stringValue;
        
        if let url = URL(string: value) ,
            url.host != nil ,
            url.host == "www.radiojavan.com",
            !value.isEmpty{
            
            
        
            self.delegate.didStartDownload();
            
            
            
            Downloader.init(url: buildUrlDownload(url: url)).start(compeletion: { (file, path, err) in
                
                
                
                if err != nil , file == nil{
                    self.delegate.didFailureDownload();
                    return;
                }
                
                
                
                self.delegate.didSuccessDownload(urlOfFile: file!, urlOfPath: path!);
                self.edtQuery.stringValue = "";


                
            }) { (progress) in
                let percents = progress * 100;
                let percentsAsInt = Int(percents);
                
                self.delegate.didProgressDownload(percents: percents, percentsAsInt: percentsAsInt);

                
            }
            
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



protocol QueryViewControllerDelegate {
    func didDownloadClick(sender: NSButton);
    func didStartDownload();
    func didFailureDownload();
    func didSuccessDownload(urlOfFile:URL , urlOfPath:URL);
    func didProgressDownload(percents:Float , percentsAsInt:Int);
}
