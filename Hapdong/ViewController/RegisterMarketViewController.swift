//
//  RegisterViewController.swift
//  Hapdong
//
//  Created by 장한솔 on 2018. 6. 1..
//  Copyright © 2018년 장한솔. All rights reserved.
//

import UIKit

class RegisterMarketViewController: UIViewController {

    @IBOutlet weak var menuContentPlusTextField: UITextField!
    let pickerView = UIPickerView()
    var contentArr = ["기획", "디자인", "iOS", "Web", "Android", "Server"]
    
    @IBOutlet weak var reviewScrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initPicker()
        
        //네비게이션바 버튼 색깔
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        //스크롤뷰 touches began
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        reviewScrollview.addGestureRecognizer(singleTapGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func scrollTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

extension RegisterMarketViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func initPicker(){
        //구현 후에 해당 pickerView의 데이터 소스와 델리게이트가 있는 위치 알려 주는 것
        pickerView.delegate = self
        pickerView.dataSource = self
        
        setTextfieldView(textField: menuContentPlusTextField, selector: #selector(selectedPicker), inputView: pickerView)
        
    }
    
    //UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //UIPickerViewDelegate
    //컴포넌트 당 row 가 몇개가 될 것인가
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contentArr.count
    }
    
    ///UIPickerViewDataSource 위한 것
    //각각의 row 에 어떠한 내용이 들어갈 것인가
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contentArr[row]
        
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
        
        menuContentPlusTextField.text = contentArr[row]
        
        view.endEditing(true)
    }
    
}


