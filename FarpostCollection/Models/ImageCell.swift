//
//  ImageCell.swift
//  FarpostCollection
//
//  Created by ios_developer on 15.02.2023.
//

import Foundation

struct ImageCell {
    
    let imageUrl: URL
    
    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }
}

extension ImageCell {
    
    static let urls = [
        "https://newcdn.mowplayer.com/689084892688/2021/07/10/thumbnails/vpv0hayivi1xmkfr.jpg",
        "https://wallpaper.dog/large/10838070.jpg",
        "https://www.humanesociety.org/sites/default/files/2022-08/hl-yp-cats-579652.jpg",
        "https://mf.b37mrtl.ru/rbthmedia/images/2022.04/original/625d3b0e77cd737e06508e1e.jpg",
        "https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2022/05/cat-1652877250.jpg",
    ]
    
    init() {
        let urlString = ImageCell.urls.randomElement()!
        let url = URL(string: urlString)
        self.init(imageUrl: url!)
    }
}
