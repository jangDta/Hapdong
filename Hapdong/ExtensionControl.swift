//
//  ExtensionControl.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 3..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
}

extension UIView {
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
