//
//  StoreService.swift
//  Hapdong
//
//  Created by 김예은 on 2018. 6. 3..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

struct StoreService: APIService {
    
    //TODO : 유저디폴트 키 값 변경
    //MARK: 가게 등록(create) - 서버 통신, 이미지 무
    static func saveMarket(category: String, name: String, description: String, menu: String, price: String, completion: @escaping (_ message: String)->Void) {
        let URL = url("/store/add")
        
        let userdefault = UserDefaults.standard
        guard let id = userdefault.string(forKey: "user_id") else { return }
        
        let body: [String: Any] = [
            "category" : category,
            "description" : description,
            "menu" : menu,
            "name" : name,
            "price" : price,
            "user_id" : id
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseData() { res in
            
            switch res.result {
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let storeData = try decoder.decode(StoreData.self, from: value)
                        
                        if storeData.message == "Successful Register Board Data" {
                            completion("success")
                        }
                        else {
                            completion("server")
                        }
                    }catch {
                        
                    }
                }
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }

    //TODO : 유저디폴트 키 값 변경
    //MARK: 가게 등록(create) - 서버 통신, 이미지 유
    static func saveImageMarket(category: String, name: String, description: String, photo: UIImage, menu: String, price: String, completion: @escaping (_ message: String)->Void) {
        let URL = url("/store/add")

        
        let userdefault = UserDefaults.standard
        guard let id = userdefault.string(forKey: "user_id") else { return }
        
        let categoryData = category.data(using: .utf8)
        let descriptionData = description.data(using: .utf8)
        let imageData = UIImageJPEGRepresentation(photo, 0.3)
        let menuData = menu.data(using: .utf8)
        let nameData = name.data(using: .utf8)
        let priceData = price.data(using: .utf8)
        let idData = id.data(using: .utf8)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(categoryData!, withName: "category")
            multipartFormData.append(descriptionData!, withName: "description")
            multipartFormData.append(imageData!, withName: "image", fileName: "photo.jpg", mimeType: "image/jpeg")
            multipartFormData.append(menuData!, withName: "menu")
            multipartFormData.append(nameData!, withName: "name")
            multipartFormData.append(priceData!, withName: "price")
            multipartFormData.append(idData!, withName: "user_id")
            
        }, to: URL, method: .post, headers: nil ) { (encodingResult) in
            
            switch encodingResult {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _) :
                
                upload.responseData(completionHandler: {(res) in
                    switch res.result {
                    case .success :
                        
                        if let value = res.result.value {
                            let message = JSON(value)["message"].string
                            
                            if message == "Successful Register Board Data" {
                                print("이미지 업로드 성공")
                                completion("success")
                            }
                            else {
                                completion("server")
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

