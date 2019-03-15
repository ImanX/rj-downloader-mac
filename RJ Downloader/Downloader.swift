//
//  Downloader.swift
//  RJ Downloader
//
//  Created by ImanX on 3/15/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
class Downloader:NSObject , URLSessionDownloadDelegate{
    
    private var url:URL!;
    private var progress:((Float)->Void)?;
    private var compeletion:((_ downloaded:URL?,_ downloaded:URL?,_ err:Error?)->Void)!;
    init(url:URL) {
        self.url = url;
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {

        
        let path = PathManager.mkDir();
        let file =  PathManager.saveFile(of: location, url: path!, name: self.url.lastPathComponent)
        compeletion(file , path , nil);

        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    
        

        if let progress = self.progress {
            let res = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite);
            progress(res);
        }
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        compeletion(nil,nil , error);
    }
    
    
    

    public func start(compeletion:@escaping (_ downloadedURLFile:URL?,_ downloadedURLPath:URL? , _ err:Error?)->Void , progress:((Float)->Void)?){
        
        self.progress = progress;
        self.compeletion = compeletion;
        
        let sesssion = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: .main)
        var request = URLRequest(url: url);
        request.httpMethod = "GET";
        let task = sesssion.downloadTask(with: request)
        task.resume();
        
        
//        if error != nil{
//            print(error.debugDescription);
//            compeletion(nil,nil,error);
//            return;
//        }
//
//        if let newResponse = (response as? HTTPURLResponse) , newResponse.statusCode == 200{
//            let path = PathManager.mkDir();
//            let file =  PathManager.saveFile(of: url!, url: path!, name: self.url.lastPathComponent)
//
//            compeletion(file,path , nil);
//
//        }
    }
}
