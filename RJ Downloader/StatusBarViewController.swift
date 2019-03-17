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
    @IBOutlet weak var container: NSView!
    
    
    private lazy var queryViewController = storyboard?.instantiateController(withIdentifier: "QueryVC") as! QueryViewController;
    private lazy var progressViewController = storyboard?.instantiateController(withIdentifier: "ProgressVC") as! ProgressViewController;
    
    
    
    
    @IBAction func didDownloadClick(_ sender: NSButton) {
    
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear();
        queryViewController.click {
            self.startDownload();
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(queryViewController);
        addChild(progressViewController);
        setup(vc: queryViewController);
        
        
    }
    
    func replace(vc:NSViewController) {
        for view in container.subviews{
            view.removeFromSuperview();
        }
        
        self.container.addSubview(vc.view);
    }
    
    func setup(vc:NSViewController)  {
        vc.view.frame = self.container.bounds;
        self.container.addSubview(vc.view);
    }
    
    func startDownload() {
        
        
        let value = queryViewController.edtQuery.stringValue;
        
        if let url = URL(string: value) ,
            url.host != nil ,
            url.host == "www.radiojavan.com",
            !value.isEmpty{
            
        
            
            
            replace(vc: progressViewController);
            
            Downloader.init(url: buildUrlDownload(url: url)).start(compeletion: { (file, path, err) in
                
        
                
                if err != nil , file == nil{
                    let alert = NSAlert();
                    alert.messageText = "Application can'nt download song :(";
                    alert.alertStyle = NSAlert.Style.warning;
                    alert.icon = NSImage(named: "NSCaution");
                    alert.beginSheetModal(for: self.view.window!, completionHandler: nil)
                    return;
                }
                
                
                
                
                NSWorkspace.shared.openFile((file?.path)!);
                self.replace(vc: self.queryViewController);
                
            }) { (progress) in
                let value = ("\(Int((progress * 100)).description)%")
                self.progressViewController.lblPercents.stringValue = value;
                
            }
            
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
