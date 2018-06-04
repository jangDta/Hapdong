//
//  ReviewList.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 4..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import Foundation

struct ReviewList : Codable{
    let review_idx : Int
    let store_idx : Int
    let user_id : String
    let review_content : String
    let review_writetime : String
    let review_img : String
}

