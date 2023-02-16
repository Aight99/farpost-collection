//
//  ImageProvider.swift
//  FarpostCollection
//
//  Created by ios_developer on 16.02.2023.
//

import UIKit

final class ImageProvider {
    
    private let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(url: URL, completion: @escaping (UIImage) -> Void) {
        
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        let session = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            self?.cache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        session.resume()
    }
    
}
