//
//  StatusBarViewController.swift
//  RJ Downloader
//
//  Created by ImanX on 3/15/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa
import ServiceManagement
class StatusBarViewController: NSViewController, QueryViewControllerDelegate, HistorySongsViewControllerDelegate{
   
    private var vmenu: NSMenu?;
    private let menus = NSMenu();
    private let userDefault = UserDefaults.standard;
    internal var statusBar:NSStatusItem!;
    

 
    @IBOutlet weak var footerContainer: NSView!
    @IBOutlet weak var container: NSView!
    
    
    private lazy var queryViewController = storyboard?.instantiateController(withIdentifier: "QueryVC") as! QueryViewController;
    private lazy var progressViewController = storyboard?.instantiateController(withIdentifier: "ProgressVC") as! ProgressViewController;
    private lazy var hisotyViewController = storyboard?.instantiateController(withIdentifier: "historyVC") as! HistorySongsViewController;
    private lazy var noHisotyViewController = storyboard?.instantiateController(withIdentifier: "NohistoryVC") as! NoHistoryViewController;
    
    
    
    
    override func viewDidAppear() {
        super.viewDidAppear();
        
        
        
     
        
        
      
        
    }
    
    
    @IBAction func menuBarClicked(_ sender: NSButton) {
        let point = NSPoint(x: sender.frame.origin.x , y: sender.frame.origin.y - (sender.frame.height / 2) )
        menus.popUp(positioning: nil, at: point, in: sender.superview);
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
        
      //  menus.addItem(withTitle: "Open RJ Downloader on Startup", action: #selector(openAsStartup(_:)), keyEquivalent: "");
        menus.addItem(NSMenuItem.separator());
        menus.addItem(withTitle: "Donate", action: #selector(donate), keyEquivalent: "");
        menus.addItem(withTitle: "About", action: #selector(about), keyEquivalent:"A");
        menus.addItem(NSMenuItem.separator());
        menus.addItem(withTitle: "Exit", action: #selector(exit), keyEquivalent: "Q");
        
        
        
      //  menus.items[0].state = userDefault.bool(forKey: "isStartupEnabled") ? .on : .off;
    }
    
    @objc func openAsStartup(_ sender:NSMenuItem){
        let state = sender.state;
        let bundle = Bundle.main.bundleIdentifier;
        let isChecked = !Bool(truncating: NSNumber(value: state.rawValue));
        sender.state = (state == .on) ? .off : .on;
        userDefault.set(isChecked, forKey: "isStartupEnabled");
        SMLoginItemSetEnabled(bundle! as CFString, !isChecked);
    }
    
    @objc func donate(){
        let url = URL(string: "https://zarinp.al/@imanX");
        NSWorkspace.shared.open(url!);
    }
   
    @objc func exit() {
        NSApplication.shared.terminate(self);
    }
    
    @objc func about(){
        let vc = storyboard?.instantiateController(withIdentifier: "aboutVC") as! AboutViewController;
        presentAsModalWindow(vc);
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




