//
//  ImageProvider.swift
//  FarpostCollection
//
//  Created by ios_developer on 16.02.2023.
//

import UIKit

extension URL {
    var filenameCorrectString: String {
        var str = self.absoluteString
        let removeCharacters: Set<Character> = ["/", ":", ",", "."]
        str.removeAll(where: { removeCharacters.contains($0) })
        str = str.count >= 255 ? String(str.suffix(255)) : str
        return str
    }
}


final class ImageProvider {
    
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    let cacheStorageDirectoryName: String
    private(set) var cacheStorageUrl: URL?
    
    init(cacheStorageDirectoryName: String = "images") {
        self.cacheStorageDirectoryName = cacheStorageDirectoryName
        setupStorage()
        tryLoadCache()
    }
    
    private func setupStorage() {
        guard let baseUrl = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        self.cacheStorageUrl = baseUrl.appendingPathComponent(cacheStorageDirectoryName)
        do {
            try fileManager.createDirectory(at: cacheStorageUrl!, withIntermediateDirectories: true)
        } catch {
            print(error)
        }
    }
    
    private func trySaveImage(image: UIImage, filename: String) {
        guard let cacheStorageUrl = cacheStorageUrl else {
            return
        }
        let imagePath = cacheStorageUrl.appendingPathComponent(filename).path
        if !fileManager.fileExists(atPath: imagePath) {
            let data = image.jpegData(compressionQuality: 1)
            fileManager.createFile(atPath: imagePath, contents: data)
        }
    }
    
    private func tryLoadCache() {
        guard let url = cacheStorageUrl else {
            return
        }
        do {
            let imageUrls = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            for imageUrl in imageUrls {
                let filename = imageUrl.lastPathComponent
                let image = UIImage(contentsOfFile: imageUrl.path)
                if let image = image {
                    cache.setObject(image, forKey: filename as NSString)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getImage(url: URL, completion: @escaping (UIImage) -> Void) {
        let cacheKey = url.filenameCorrectString as NSString
        if let cachedImage = cache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        let session = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            self?.cache.setObject(image, forKey: cacheKey)
            self?.trySaveImage(image: image, filename: cacheKey as String)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        session.resume()
    }
}
