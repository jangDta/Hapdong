//
//  RegisterReviewViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class RegisterReviewViewController: UIViewController {
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    //TODO: 전 뷰에서 인텐트로 받아오기
    var store_idx: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        print("랄라\(store_idx)")
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
    }

    @IBAction func openImagePicker(_ sender: UITapGestureRecognizer) {
        openGallery()
    }
    
    @IBAction func onRegister(_ sender: UIButton) {
        
        if (contentTextView.text?.isEmpty)! {
            
            let dialog = UIAlertController(title: "리뷰 등록 실패", message: "모든 항목을 입력하세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            self.present(dialog, animated: true, completion: nil)
        }
        
        else {
            print("click")
            saveReview(content: contentTextView.text!, store_idx: store_idx)
        }
    }
    
    func saveReview(content: String, store_idx: Int) {
        if let img = reviewImageView.image { //이미지가 있을 때
            print(store_idx)
            ReviewService.saveImageReview(content: content, photo: img, store_idx: store_idx) {
                print("성공")
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

// MARK: 이미지 첨부
extension RegisterReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Method
    @objc func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    // imagePickerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("사용자가 취소함")
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        defer {
        //            self.dismiss(animated: true) {
        //                print("이미지 피커 사라짐")
        //            }
        //        }
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            reviewImageView.image = editedImage
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            reviewImageView.image = originalImage
        }
        
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
}

