//
//  AddQuestionVC.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/12/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit
/*
 To add the question inside the present cell this Class is being used.
 
 */
class AddQuestionVC: UIViewController {

    @IBOutlet var txtView: UITextView!
    @IBOutlet var tblView: UITableView!
    var objQuestions = Questions()

    @IBOutlet var btnSave: UIButton!
    @IBOutlet var lblMinimumCharacter: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpNavigationBarOnView()
        txtView.setUITextView()
        setUIAccordingtoDevice()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.txtView.becomeFirstResponder()
        }
    }
    //MARK: - Set Navigation
    func SetUpNavigationBarOnView() {
        let aViewNav = ViewNavBar()
        aViewNav.setNavBar(strTitle: "Add New Question", btnLeft: true, sourceController: self, btnImgName: "") { (keyPressed) in
            if keyPressed == "back"
            {
            self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - Setup UI
    func setUIAccordingtoDevice()
    {
        txtView.font = UIFont(name: "Georgia", size: AppConstant.IS_IPAD ? 25 : 20)!
        lblMinimumCharacter.font = UIFont(name: "Georgia", size: AppConstant.IS_IPAD ? 15 : 10)!
        btnSave.titleLabel?.font = UIFont(name: "Georgia", size: AppConstant.IS_IPAD ? 25 : 20)!
        btnSave.layer.cornerRadius = 5.0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnSaveAction(_ sender: Any) {
        txtView.resignFirstResponder()
        
        if CheckValidation().ValidateTextView(txtView: txtView)  {
        objQuestions.question = txtView.text!
        checkforRadioCheckboxOptions()
        self.navigationController?.popViewController(animated: true)
        }
        else{
            UIAlertController.showAlertWithOkButton(self, aStrMessage: "Enter a non empty and more than 20 characters for question.") { (index, value) in
            }
        }
    }
    /*
    for radio and checkbox options
     
     click unclick on the cell is managed.
     data is added into the arrResponse of the json file.
     */
    func checkforRadioCheckboxOptions()
    {
        if objQuestions.type == contentType.checkbox.rawValue || objQuestions.type == contentType.radio.rawValue
        {
            if  objQuestions.arrOption.count > 2
            {
                json.arrQuestionResponse.append(objQuestions)
            }
            else
            {
                UIAlertController.showAlertWithOkButton(self, aStrMessage: "Select atleast two option.") { (index, value) in
                    
                }
            }
        }else{
            json.arrQuestionResponse.append(objQuestions)
        }
    }
}
extension AddQuestionVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch objQuestions.type {
        case contentType.checkbox.rawValue, contentType.radio.rawValue:
            return 1
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch objQuestions.type {
        case contentType.checkbox.rawValue, contentType.radio.rawValue:
            return json.arrAnswerResponse.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let aView = UIView()
        aView.backgroundColor = UIColor.white
        let alabel = UILabel()
        alabel.frame = CGRect(x: 20, y: 0, width: AppConstant.FRAME_WIDTH, height: 30)
        alabel.font = UIFont(name: "Georgia", size: AppConstant.IS_IPAD ? 22 : 17)!

        alabel.textColor = UIColor.darkGray
        alabel.text = "Choose the Options For your Question."
        aView.addSubview(alabel)
        return aView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aDict = json.arrAnswerResponse[indexPath.row]
        let strCellIdentifier = "tblCellRadio"
        let cell = tblView.dequeueReusableCell(withIdentifier: strCellIdentifier, for: indexPath) as! TblCellAnswer
        cell.btnRadio.isSelected = false
        if objQuestions.arrOption.contains(aDict.id){
            cell.btnRadio.isSelected = true
        }
        cell.lblTitle.font = UIFont(name: "Georgia", size: AppConstant.IS_IPAD ? 22 : 17)!
        cell.lblTitle.text = aDict.value
        cell.selectionStyle = .none
        return cell
    }
}

extension AddQuestionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppConstant.IS_IPAD ? 70 : 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let aDict = json.arrAnswerResponse[indexPath.row]
        if objQuestions.type == contentType.checkbox.rawValue || objQuestions.type == contentType.radio.rawValue{
            if objQuestions.arrOption.contains(aDict.id)
            {
                guard let index = objQuestions.arrOption.index(of: aDict.id)else{return}
                objQuestions.arrOption.remove(at: index)
            }else{
                objQuestions.arrOption.append(aDict.id)
            }
        }
        tblView.reloadData()
    }
}

