//
//  MetadataResolver.swift
//  RJ Downloader
//
//  Created by ImanX on 3/17/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import MediaPlayer
import Cocoa

class MetadataResolver {
    
    class func getMetas(urls:[URL])->[Music] {
        var musics = [Music]();
        for item in urls {
            musics.append(meta(url: item))  ;
        }
        
        return musics;
        
    }
    
    private class func meta(url:URL)->Music{
        let music = Music(file: url);
        let playerItem = AVPlayerItem(url: url)
        let metadataList = playerItem.asset.commonMetadata
        for item in metadataList {
            guard let key = item.commonKey, let value = item.value else{
                continue
            }
            
            
            switch key.rawValue {
            case "title" : music.title = value as? String;
            case "artist":  music.artist = value as? String;
            case "albumName" :music.album = value as? String;
            case "artwork":
               let image = NSImage(data: value as! Data)
               music.photo = image;
                break;
            default:
                continue
            }
            
        }
        
        return music;
        
    }
}
