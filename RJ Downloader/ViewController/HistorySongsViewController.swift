//
//  HistorySongsViewController.swift
//  RJ Downloader
//
//  Created by ImanX on 3/19/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Cocoa

class HistorySongsViewController: NSViewController , NSTableViewDataSource , NSTableViewDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    private var musics:[Music]?;
    internal var delegate:HistorySongsViewControllerDelegate!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.action = #selector(rowClick);

    }
    
    @objc func rowClick(){
        let url = musics?[tableView.clickedRow].file;
        NSWorkspace.shared.openFile((url?.path)!);
        
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return musics?.count ?? 0;
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
    
    
    func reloadData() {
        guard let files = PathManager.getFiles() else{
            self.delegate.didReloadData(hasHistory: false, data: nil);
            return;
        }
        
        self.musics =  MetadataResolver.getMetas(urls: files);
        self.delegate.didReloadData(hasHistory: true, data: musics);
        self.tableView.reloadData();
    }
    
}


protocol HistorySongsViewControllerDelegate  {
    func didReloadData(hasHistory:Bool , data:[Music]?);
}
