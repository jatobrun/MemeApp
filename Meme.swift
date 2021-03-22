//
//  Meme.swift
//  MemeAppV1
//
//  Created by Jamil Torres on 17/3/21.
//

import Foundation
import UIKit
struct Meme{
    let topText:String?
    let bottomText:String?
    let originalImage:UIImage?
    let memeImage:UIImage?
    
    init(topText:String?, bottomText:String?, originalImage:UIImage?, memeImage:UIImage?) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memeImage = memeImage
    }
}
