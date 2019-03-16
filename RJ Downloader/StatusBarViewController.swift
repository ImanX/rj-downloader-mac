//
//  StatusBarViewController.swift
//  RJ Downloader
//
//  Created by ImanX on 3/15/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa
class StatusBarViewController: NSViewController{
    
    
    
    internal var statusBar:NSStatusItem!;
   
    @IBOutlet var edtDownload: NSTextField!
    @IBOutlet weak var lblProgress: NSTextField!
    @IBOutlet weak var progressView: NSView!
    @IBOutlet weak var mainView: NSView!
    @IBOutlet weak var indicator: NSProgressIndicator!
    
    
    
    @IBAction func didDownloadClick(_ sender: NSButton) {
        
        
        
        
        if let url = URL(string: edtDownload.stringValue) ,
            url.host != nil ,
            url.host == "www.radiojavan.com",
            !edtDownload.stringValue.isEmpty{
          
            
            
            
            mainView.isHidden = true;
            progressView.isHidden = false;
            edtDownload.stringValue = "";
            
            
         
            Downloader.init(url: buildUrlDownload(url: url)).start(compeletion: { (file, path, err) in
                
                self.mainView.isHidden = false;
                self.progressView.isHidden = true;
                
                if err != nil , file == nil{
                    let alert = NSAlert();
                    alert.messageText = "Application can'nt download song :(";
                    alert.alertStyle = NSAlert.Style.warning;
                    alert.icon = NSImage(named: "NSCaution");
                    alert.beginSheetModal(for: self.view.window!, completionHandler: nil)
                    return;
                }
                
                
                
             
                NSWorkspace.shared.openFile((file?.path)!);
                
            }) { (progress) in
                let value = ("\(Int((progress * 100)).description)%")
                self.lblProgress.stringValue = value;
            }
            
        }
    }
    
    
    
    override func viewDidAppear() {
        recognizerClipboard();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimation(nil);
    }
    
    
    
    func recognizerClipboard() {
        
      let valueBoard =  NSPasteboard.general.pasteboardItems?.first?.string(forType: .string);
        
        guard let value = valueBoard else {
            return;
        }
        
        if let url = URL(string: value) , url.host == "www.radiojavan.com" {
            edtDownload.stringValue = url.absoluteString;
        }
        
    }
    
    
    
    
    
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
