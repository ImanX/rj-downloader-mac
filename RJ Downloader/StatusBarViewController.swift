//
//  StatusBarViewController.swift
//  RJ Downloader
//
//  Created by ImanX on 3/15/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa
class StatusBarViewController: NSViewController, QueryViewControllerDelegate, HistorySongsViewControllerDelegate{
   
    
 
    @IBOutlet weak var footerContainer: NSView!
    
    
    
    internal var statusBar:NSStatusItem!;
    @IBOutlet weak var container: NSView!
    
    private lazy var queryViewController = storyboard?.instantiateController(withIdentifier: "QueryVC") as! QueryViewController;
    private lazy var progressViewController = storyboard?.instantiateController(withIdentifier: "ProgressVC") as! ProgressViewController;
    private lazy var hisotyViewController = storyboard?.instantiateController(withIdentifier: "historyVC") as! HistorySongsViewController;
    private lazy var noHisotyViewController = storyboard?.instantiateController(withIdentifier: "NohistoryVC") as! NoHistoryViewController;
    
    
    private var vmenu: NSMenu?;
    
    
    override func viewDidAppear() {
        super.viewDidAppear();
        
    }
    
    @IBAction func menuBarClicked(_ sender: NSButton) {
        
        let menu = NSMenu();
        menu.addItem(withTitle: "About", action: nil, keyEquivalent:"");
        menu.addItem(withTitle: "Exit", action: #selector(exit), keyEquivalent: "");
        let point = NSPoint(x: sender.frame.origin.x , y: sender.frame.origin.y - (sender.frame.height / 2) )
        menu.popUp(positioning: nil, at: point, in: sender.superview);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(queryViewController);
        addChild(progressViewController);
        addChild(noHisotyViewController);
        addChild(hisotyViewController);


        setup(container: container,vc: queryViewController);
        setup(container: footerContainer,vc: noHisotyViewController);

        
        queryViewController.delegate = self;
        hisotyViewController.delegate = self;
        hisotyViewController.reloadData();
    }
    
   
    @objc func exit() {
        NSApplication.shared.terminate(self);
    }
    

    func didSuccessDownload(urlOfFile: URL, urlOfPath: URL) {
        self.progressViewController.lblPercents.stringValue = "0%"
        NSWorkspace.shared.openFile((urlOfFile.path));
        self.hisotyViewController.reloadData();
        self.replace(container: container,vc: self.queryViewController);
    }
    
    func didDownloadClick(sender: NSButton) {
        
    }
    
    func didStartDownload() {
        self.replace(container: container,vc: self.progressViewController);

    }
    
    func didFailureDownload() {
        let alert = NSAlert();
        alert.messageText = "Application can'nt download song :(";
        alert.alertStyle = NSAlert.Style.warning;
        alert.icon = NSImage(named: "NSCaution");
        alert.beginSheetModal(for: self.view.window!, completionHandler: nil)
    }
    
    
    
    func didProgressDownload(percents: Float, percentsAsInt: Int) {
      progressViewController.lblPercents.stringValue  = "\(percentsAsInt)%";
    }
    
    
    func didReloadData(hasHistory: Bool, data: [Music]?) {
        replace(container: footerContainer, vc: hasHistory ? hisotyViewController : noHisotyViewController);
    }
    

    
    
    
    func replace(container:NSView, vc:NSViewController) {
        for view in container.subviews{
            view.removeFromSuperview();
        }
        
        container.addSubview(vc.view);
    }
    
    func setup(container:NSView,vc:NSViewController)  {
        vc.view.frame = container.bounds;
        container.addSubview(vc.view);
    }
    
    
}




