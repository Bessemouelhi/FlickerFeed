//
//  Photo.swift
//  FlikrFeed
//
//  Created by Apple on 29/03/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation

struct Photo {
    
    let farm: Int
    let id: String
    let isfamily: Bool
    let isfriend: Bool
    let ispublic: Bool
    let owner: String
    let secret: String
    let server: String
    let title: String
    
    func getUrl_small() -> String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_s.jpg"
    }
    
    func getUrl(size: String) -> String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg"
    }
    
}

