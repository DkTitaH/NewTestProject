//
//  UIImageView+Extensions.swift
//  TestTechnology
//
//  Created by iphonovv on 26.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func setImageFrom(urlString: String) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        
        if self.image == nil {
            self.addSubview(activityIndicator)
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    debugPrint(error ?? "No Error")
                    return
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    activityIndicator.removeFromSuperview()
                    self.image = image
                })
                
            }).resume()
        }
    }
}
