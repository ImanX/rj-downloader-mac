//
//  PathManager.swift
//  RJ Downloader
//
//  Created by ImanX on 3/15/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
class PathManager {
    
    
    private static let fileManager = FileManager.default;
    
    
    public class func mkDir() -> URL?{
        
        guard var filePath = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first else{
            return nil;
        }
        
        filePath = filePath.appendingPathComponent("mp3s");
        if !fileManager.fileExists(atPath: filePath.path){
            do{
                try! fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil);
                
                return filePath;
            }
        }else{
            return filePath;
        }
        
    }
    
    
    public class func saveFile(of:URL,url:URL ,name:String)->URL?{
        let fileUrl = url;
        let destinationFile = fileUrl.appendingPathComponent(name);
        if fileManager.fileExists(atPath: destinationFile.path){
            return destinationFile;
        }
        
        do{
           try! fileManager.moveItem(at: of, to: destinationFile)
            return destinationFile;
        }catch{
            return nil;
        }
        
    }
    
    
    public class func getFiles()->[URL]?{
        guard var path = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first else{
            return nil;
        }
       
        do{
            path.appendPathComponent("mp3s");
            let dirs = try fileManager.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: []);
            
            let files = dirs.filter { (url) -> Bool in
               return  url.pathExtension == "mp3";
            }
            
            
            return files;
            
        }catch{
            return nil;
        }
    }
}
