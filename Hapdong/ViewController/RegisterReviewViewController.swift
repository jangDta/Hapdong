//
//  RegisterReviewViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class RegisterReviewViewController: UIViewController {
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    //TODO: 전 뷰에서 인텐트로 받아오기
    var store_idx: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRegister(_ sender: UIButton) {
        
        if (categoryTextField.text?.isEmpty == true || contentTextField.text?.isEmpty == true) {
            
            let dialog = UIAlertController(title: "리뷰 등록 실패", message: "모든 항목을 입력하세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            self.present(dialog, animated: true, completion: nil)
        }
        
        else {
            saveReview(content: contentTextField.text!, store_idx: store_idx)
        }
    }
    
    func saveReview(content: String, store_idx: String) {
        if let img = reviewImageView.image { //이미지가 있을 때
            
            ReviewService.saveImageReview(content: content, photo: img, store_idx: store_idx) {
                self.navigationController?.popViewController(animated: true)
            }
        }
            
        else { //이미지가 없을 때
            ReviewService.saveReview(content: content, store_idx: store_idx) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    


}
