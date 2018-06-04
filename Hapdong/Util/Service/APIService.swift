//
//  APIService.swift
//  Hapdong
//
//  Created by 김예은 on 2018. 6. 3..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import Foundation

protocol APIService {
    
}

extension APIService {
    static func url(_ path: String) -> String {
        return "http://13.124.11.199:3000" + path
    }
}
