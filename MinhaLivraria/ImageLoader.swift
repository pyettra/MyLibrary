//
//  ImageLoader.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 15/02/24.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()
    
    func load(with urlString: String, completion: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        if let image = cache.object(forKey: urlString as NSString) {
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, _ in
            guard let self = self else { return }
            guard let data = data, let image = UIImage(data: data) else {
                completion(UIImage(named: ""))
                return
            }
            
            self.cache.setObject(image, forKey: urlString as NSString)
            completion(image)
            return
        }.resume()
    }
}
