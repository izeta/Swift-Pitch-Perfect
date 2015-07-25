//
//  RecordedAudio.swift
//  Lengthy Voice
//
//  Created by Zeta on 7/13/15.
//  Copyright (c) 2015 Zeta. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL
    var title: String
    
    override init() {
        filePathUrl = NSURL()
        title = ""
    }
    
    init(title:String, filePathUrl:NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
}