//
//  TblCellAnswer.Swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit
protocol TableCellDelegate {
    func reloadTableData(intIndex:Int)
}
class TblCellAnswer: UITableViewCell,UITextViewDelegate,UITextFieldDelegate, SaveButtonDelegate {
    var reloadDelegate: TableCellDelegate?
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnRadio: UIButton!
    @IBOutlet var txtAnswer: UITextField!
    @IBOutlet var txtValue: UITextView!
    @IBOutlet var lblValue: UILabel!
    
    override func awakeFromNib() {
        if lblValue != nil
        {
            lblValue.font = UIFont(name: "Georgia", size: AppConstant.IS_IPAD ? 20 : 17)!
        }
        
    }
    func setAnswerinsideCell(intValue : Int)
    {
        lblValue.text = self.getAnswerFromID(intValue: intValue)
    }
    
    func  getAnswerFromID (intValue : Int) -> String
    {
        if btnRadio != nil{btnRadio.isSelected = false}
        var strValue = ""
        for value in json.arrAnswerResponse
        {
            if value.id == intValue
            {
                strValue = value.value
                if btnRadio != nil && (dictQuestion.type == contentType.checkbox.rawValue || dictQuestion.type == contentType.radio.rawValue)   {
                    if (dictQuestion.arrAnswer.contains(intValue))
                    {
                        btnRadio.isSelected = true
                    }
                }
                break;
            }
        }
        return strValue
    }
    func  getQuestionFromID (intValue : Int, dictValue : Questions)
    {
        for (index,value) in json.arrQuestionResponse.enumerated()
        {
            if value.id == intValue
            {
                print(json.arrQuestionResponse[index])
                json.arrQuestionResponse[index] = dictValue
                break;
            }
        }
    }
    func setUITextView()
    {
        txtValue.setUITextView()
    }
    
    func configureDynamicCellConfiguration(aDictValue : Questions, intValue : Int)
    {
        //        print("dict initialized",aDictValue)
        
        dictQuestion = aDictValue
        switch aDictValue.type {
        case contentType.textView.rawValue:
            setUITextView()
            txtValue.text = aDictValue.Answer
        case contentType.text.rawValue:
            setUITextView()
            txtValue.text = aDictValue.Answer
        case contentType.datePicker.rawValue:
            txtAnswer.delegate = self
            txtAnswer.text = aDictValue.Answer
        case contentType.picker.rawValue:
            txtAnswer.delegate = self
            txtAnswer.text = aDictValue.Answer + "  CM"
        case contentType.radio.rawValue, contentType.checkbox.rawValue:
            if contentType.checkbox.rawValue == dictQuestion.type
            {
                btnRadio.setImage(UIImage(named: "ico_check0"), for: .normal)
                btnRadio.setImage(UIImage(named: "ico_success_CAT5.png"), for: .selected)
            }
            lblTitle.text = getAnswerFromID(intValue: intValue)
            btnRadio.tag = intValue
            btnRadio.addTarget(self, action: #selector(btnRadioAction(sender:)), for: .touchUpInside)
        default:
            print("default")
        }
    }
    
    //MARK:UITextfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtAnswer && dictQuestion.type == contentType.datePicker.rawValue
        {
            let strDate = dictQuestion.Answer == "" ? makeDate(year: 1992, month: 05, day: 18) : dictQuestion.Answer
            let aDate = getDateFromString(strDate: strDate)
            let  aPickerView = CustomeDatePicker(frame: CGRect(x: 0, y: 0, width: FRAME_WIDTH, height: 216))
            aPickerView.showDateTimePicker(aDate: aDate,aMinumumDate:Calendar.current.date(byAdding: .year, value: -100, to: Date())!,aLocale: NSLocale(localeIdentifier: "en_GB") as Locale, withCompletionBlock: { (dte) in
                self.txtAnswer.text = getStringDate(dateValue: dte)
                dictQuestion.Answer = self.txtAnswer.text!
                self.txtAnswer.resignFirstResponder()
            })
            txtAnswer.inputView = aPickerView
        }
        if textField == txtAnswer && dictQuestion.type == contentType.picker.rawValue
        {
            let arrHeight : [String] = (20...300).map{String($0)}
            let  aPickerView = GlobalPickerView(frame: CGRect(x: 0, y: 0, width: FRAME_WIDTH, height: 216))
            aPickerView.showPicker(strSelectedIndex:dictQuestion.Answer, array: arrHeight , withCompletionBlock: { (strValue,strDone) in
                self.txtAnswer.text = strValue + "  CM"
                dictQuestion.Answer = strValue
                self.txtAnswer.resignFirstResponder()
            })
            txtAnswer.inputView = aPickerView
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    @objc func btnRadioAction(sender : UIButton)
    {
        if dictQuestion.type == contentType.checkbox.rawValue{
            if dictQuestion.arrAnswer.contains(sender.tag)
            {
                guard let index = dictQuestion.arrAnswer.index(of: sender.tag)else{return}
                dictQuestion.arrAnswer.remove(at: index)
                btnRadio.isSelected = false
            }else{
                dictQuestion.arrAnswer.append(sender.tag)
                btnRadio.isSelected = true
            }
            reloadDelegate!.reloadTableData(intIndex: 0)
        }else{
            
            dictQuestion.arrAnswer.removeAll()
            dictQuestion.arrAnswer.append(sender.tag)
            reloadDelegate!.reloadTableData(intIndex: 0)
        }
    }
    
    func btnSaveAction() {
        print("action footer")
        if txtValue != nil{
            self.txtValue.resignFirstResponder()
            dictQuestion.Answer = self.txtValue.text!
        }
        self.getQuestionFromID(intValue: dictQuestion.id, dictValue: dictQuestion)
        
    }
}

