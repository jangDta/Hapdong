//
//  ListData.swift
//  Hapdong
//
//  Created by 김예은 on 2018. 6. 4..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import Foundation

struct ListData: Codable {
    let message: String
    let myPosts: [List]
}
