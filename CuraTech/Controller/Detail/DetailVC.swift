//
//  DetailVC.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit
/*
 On the click of save button passing the data between the cell and the View controller
 */
protocol SaveButtonDelegate {
    func btnSaveAction()
}
class DetailVC: UIViewController,TableCellDelegate {
    
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var tblView: UITableView!
    var objQuestions = Questions()
    var saveDelegate: SaveButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.IS_IPAD{view.backgroundColor = UIColor.clear
            view.isOpaque = false}else{
            // Do any additional setup after loading the view.
            SetUpNavigationBarOnView()
            
        }
        btnSave.layer.cornerRadius = 5.0
    }
    //MARK: - Set Navigation
    /*
 
 */
    func SetUpNavigationBarOnView() {
        let aViewNav = ViewNavBar()
        aViewNav.setNavBar(strTitle: "Select Answer", btnLeft: true, sourceController: self, btnImgName: "") { (keyPressed) in
            if keyPressed == "back"
            {
            self.navigationController?.popViewController(animated: true)
            }
        }
    }
    @IBAction func btnSaveAction(_ sender: Any) {
        saveDelegate?.btnSaveAction()
        if AppConstant.IS_IPAD{
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("reloadTable"), object: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    func reloadTableData(intIndex : Int)
    {
        objQuestions = dictQuestion
        tblView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
var dictQuestion = Questions()
/*
    An enum is used to differentiate the different cells on the tableView
 1. datepicker - a datepicker will be shown.
 2. picker - a picker with the int value is used here.
 3. text - a normal textfield will be shown.
 4. radio - single select field is opened.
 5. checkbox - multiple select is open from it.
 */
extension DetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch objQuestions.type {
        case contentType.checkbox.rawValue, contentType.radio.rawValue:
            return objQuestions.arrOption.count
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: strType.question.rawValue) as! TblCellAnswer
        cellHeader.lblValue.text = objQuestions.question
        return cellHeader.contentView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index = 0
        if objQuestions.arrOption.count>0{
            index = objQuestions.arrOption[indexPath.row]
        }
        var strCellIdentifier = ""
        switch objQuestions.type {
        case contentType.checkbox.rawValue,contentType.radio.rawValue:
            strCellIdentifier = strType.radio.rawValue
        case contentType.textView.rawValue:
            strCellIdentifier = strType.textView.rawValue
        default:
            strCellIdentifier = strType.text.rawValue
        }
        let cell = tblView.dequeueReusableCell(withIdentifier: strCellIdentifier, for: indexPath) as! TblCellAnswer
        self.saveDelegate = cell
        cell.reloadDelegate = self
        cell.configureDynamicCellConfiguration(aDictValue: objQuestions, intValue:index)
        cell.selectionStyle = .none
        return cell
    }
}

extension DetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch objQuestions.type {
        case contentType.checkbox.rawValue, contentType.radio.rawValue, contentType.text.rawValue:
            return 60;
        case  contentType.text.rawValue:
            return 100;
        default:
            return UITableViewAutomaticDimension
        }
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
