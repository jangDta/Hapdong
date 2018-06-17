//
//  RegisterViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class RegisterMarketViewController: UIViewController {
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var marketImageView: UIImageView!
    @IBOutlet weak var menuNameTextField: UITextField!
    @IBOutlet weak var menuPriceTextField: UITextField!
    
    @IBOutlet weak var menuContentPlusTextField: UITextField!
    let pickerView = UIPickerView()
   // var contentArr = ["기획", "디자인", "iOS", "Web", "Android", "Server"]
    var categoryArr = ["korean", "chicken", "pizza", "night"]
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    var stores: [Store] = [Store]()
    let userdefault = UserDefaults()
    
    @IBOutlet weak var reviewScrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //contentArr += ["예은이의","정성을","주석할수","없었습니다"]
        
        initPicker()
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        //스크롤뷰 touches began
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        reviewScrollview.addGestureRecognizer(singleTapGestureRecognizer)
        
        marketImageView.isUserInteractionEnabled = true
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func scrollTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func openImagePicker(_ sender: UITapGestureRecognizer) {
        openGallery()
    }
    
    
    //MARK: 가게 등록(액션)
    @IBAction func onRegister(_ sender: UIButton) {
        if (categoryTextField.text?.isEmpty == true || nameTextField.text?.isEmpty == true || descriptionTextField.text?.isEmpty == true ||
            menuNameTextField.text?.isEmpty == true || menuPriceTextField.text?.isEmpty == true) {
            
            let dialog = UIAlertController(title: "가게 등록 실패", message: "모든 항목을 입력하세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            self.present(dialog, animated: true, completion: nil)
        }
            
        else {
            saveContent(category: categoryTextField.text!, name: nameTextField.text!, description: descriptionTextField.text!, menu: menuNameTextField.text!, price: menuPriceTextField.text!)
        }
    }
    
    // MARK: 글 저장(create)
    func saveContent(category: String, name: String, description: String, menu: String, price: String) {
        
        if let img = marketImageView.image { //이미지가 있을 때
            
            StoreService.saveImageMarket(category: category, name: name, description: description, photo: img, menu: menu, price: price) { (message) in
                if message == "success" {
                    
                self.navigationController?.popViewController(animated: true)
                    
                }
                else {
                    let dialog = UIAlertController(title: "서버 에러", message: "통신 상태를 확인해주세요.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                    dialog.addAction(action)
                    self.present(dialog, animated: true, completion: nil)
                }
            }
        }
            
        else { //이미지가 없을 때
            StoreService.saveMarket(category: category, name: name, description: description, menu: menu, price: price) { (message) in
                if message == "success" {
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    let dialog = UIAlertController(title: "서버 에러", message: "통신 상태를 확인해주세요.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                    dialog.addAction(action)
                    self.present(dialog, animated: true, completion: nil)
                }
            }
        }
    }
}

// MARK: 이미지 첨부
extension RegisterMarketViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        defer {
        //            self.dismiss(animated: true) {
        //                print("이미지 피커 사라짐")
        //            }
        //        }
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            marketImageView.image = editedImage
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            marketImageView.image = originalImage
        }
        
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
}


extension RegisterMarketViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func initPicker(){
        //구현 후에 해당 pickerView의 데이터 소스와 델리게이트가 있는 위치 알려 주는 것
        pickerView.delegate = self
        pickerView.dataSource = self
        
        setTextfieldView(textField: categoryTextField, selector: #selector(selectedPicker), inputView: pickerView)
    
    }
    
    //UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //UIPickerViewDelegate
    //컴포넌트 당 row 가 몇개가 될 것인가
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArr.count
    }
    
    ///UIPickerViewDataSource 위한 것
    //각각의 row 에 어떠한 내용이 들어갈 것인가
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArr[row]
        
    }
    
    
    func setTextfieldView(textField:UITextField, selector : Selector, inputView : Any){
        
        let bar = UIToolbar()
        bar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "확인", style: .done
            , target: self, action: selector)
        
        bar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = bar
        
        if let tempView = inputView as? UIView {
            textField.inputView = tempView
        }
        if let tempView = inputView as? UIControl {
            textField.inputView = tempView
        }
        
    }
    
    @objc func selectedPicker(){
        
        let row = pickerView.selectedRow(inComponent: 0)
        
        categoryTextField.text = categoryArr[row]
        
        view.endEditing(true)
    }
    
}



