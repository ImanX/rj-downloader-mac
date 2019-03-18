//
//  StatusBarViewController.swift
//  RJ Downloader
//
//  Created by ImanX on 3/15/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa
class StatusBarViewController: NSViewController , NSTableViewDataSource , NSTableViewDelegate{
    
    
    
    internal var statusBar:NSStatusItem!;
    @IBOutlet weak var container: NSView!
    
    
    @IBOutlet weak var tableView: NSTableView!
    private lazy var queryViewController = storyboard?.instantiateController(withIdentifier: "QueryVC") as! QueryViewController;
    private lazy var progressViewController = storyboard?.instantiateController(withIdentifier: "ProgressVC") as! ProgressViewController;
    private var vmenu: NSMenu?;
    private var musics:[Music]?;
    
    
    override func viewDidAppear() {
        super.viewDidAppear();
        queryViewController.click {
            self.startDownload();
        }
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
        setup(vc: queryViewController);
        tableView.action = #selector(rowClick);
        guard let files = PathManager.getFiles() else{
            return;
        }
        
        self.musics =  MetadataResolver.getMetas(urls: files);
        
    }
    
    @objc func rowClick(){
        let url = musics?[tableView.clickedRow].file;
        NSWorkspace.shared.openFile((url?.path)!);

    }
    @objc func exit() {
        NSApplication.shared.terminate(self);
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
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (musics?.count)!;
    }
    


    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        print("adasd");
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let music = self.musics![row];
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultRow"), owner: self) as! NSMusicCell;
        cell.imgArtwork.image = music.photo;
        cell.lblName.stringValue = music.title!;
        cell.lblArtist.stringValue = music.artist!;

        return cell;
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
                
                
                
                
                self.progressViewController.lblPercents.stringValue = "0%"
                self.queryViewController.edtQuery.stringValue = "";
                NSWorkspace.shared.openFile((file?.path)!);
                self.replace(vc: self.queryViewController);
                
            }) { (progress) in
                let value = ("\(Int((progress * 100)).description)%")
                self.progressViewController.lblPercents.stringValue = value;
                
            }
            
        }
    }
    
    
}




