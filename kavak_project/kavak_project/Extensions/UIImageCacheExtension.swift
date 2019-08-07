//
//  UIImageCacheExtension.swift
//  kavak_project
//
//  Created by Eduardo Fonseca on 8/5/19.
//  Copyright © 2019 Eduardo Fonseca. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func cacheImage(imageUrl urlString: String, celda cel:UICollectionViewCell  = UICollectionViewCell.init())
    {
        let url = URL(string: urlString)
        
        image = #imageLiteral(resourceName: "placeholder_image")
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            
            return
        }
        
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: response)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
            }.resume()
    }

}
