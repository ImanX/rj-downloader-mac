//
//  Global.swift
//  RJ Downloader
//
//  Created by ImanX on 3/15/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation

public let URL_DOWNLOAD = "https://host2.rjmusicmedia.com/media/mp3/mp3-256/";


public func buildUrlDownload(url:URL) ->URL{
    let match = url.lastPathComponent.matches(for: "[^?+]");
    return URL(string:("\(URL_DOWNLOAD)\(match).mp3"))!;
    
}
