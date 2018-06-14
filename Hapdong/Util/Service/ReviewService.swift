//
//  ReviewService.swift
//  Hapdong
//
//  Created by 김예은 on 2018. 6. 4..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

struct ReviewService: APIService {
    
    //MARK: 리뷰 등록(create) - 이미지 무
    static func saveReview(content: String, store_idx: Int, completion: @escaping ()->Void) {
        
        let URL = url("/store/addreview")
        
        let userdefault = UserDefaults.standard
        guard let id = userdefault.string(forKey: "user_id") else {return}
        
        let body: [String: Any] = [
            "content" : content,
            "id" : id,
            "store_idx" : store_idx
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseData() { res in
            
            switch res.result {
            case .success:
                if let value = res.result.value {
                    
                    let message = JSON(value)["message"].string
                    
                    if message == "Successful Register Board Data" {
                        completion()
                    }
                }
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    //MARK: 리뷰 등록(create) - 이미지 유
    static func saveImageReview(content: String, photo: UIImage, store_idx: Int, completion: @escaping ()->Void) {
        let URL = url("/store/addreview")
        
        let userdefault = UserDefaults.standard
        guard let id = userdefault.string(forKey: "user_id") else {return}
        
        let contentData = content.data(using: .utf8)
        let photoData = UIImageJPEGRepresentation(photo, 0.3)
        let idData = id.data(using: .utf8)
        let storeIdxData = String(store_idx).data(using: .utf8)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(contentData!, withName: "content")
            multipartFormData.append(photoData!, withName: "image", fileName: "photo.jpg", mimeType: "image/jpeg")
            multipartFormData.append(idData!, withName: "id")
            multipartFormData.append("\(store_idx)".data(using: .utf8)!, withName: "store_idx")
            
        }, to: URL, method: .post, headers: nil ) { (encodingResult) in
            
            switch encodingResult {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _) :
                print("hhhhhhhhhhhhhhhhhhhhh1")
                upload.responseData(completionHandler: {(res) in
                    switch res.result {
                    case .success :
                        print("hhhhhhhhhhhhhhhhhhhhh2")
                        if let value = res.result.value {
                            let message = JSON(value)["message"].string
                            print("ㄴㄴ\(message)")
                            print(id)
                            if message == "Successful Register Board Data" {
                                print("이미지 업로드 성공")
                                completion()
                            }
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                })
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }

    }
}
