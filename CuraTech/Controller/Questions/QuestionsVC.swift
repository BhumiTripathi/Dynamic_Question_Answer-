//
//  QuestionsVC.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit
let json = JsonData()

class QuestionsVC: UIViewController {
    
    @IBOutlet var tblView: UITableView!
    let strTableCellIdentifier = "TblCellDataListing"
    let strTableCellIdentifierAnswer = "TblCellAnswer"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        getQuestionDataFromBundle()
        SetUpNavigationBarOnView()
        NotificationCenter.default.addObserver(self, selector: #selector(tblReload), name: Notification.Name("reloadTable"), object: nil)

    }
    override func viewWillAppear(_ animated: Bool) {
        AddFloatingButtonOnView()
        tblView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        RemoveFloatingButtonFromWindow()
    }
    @objc func tblReload()
    {
        tblView.reloadData()
    }
    
    //MARK: - Set Navigation
    
    func SetUpNavigationBarOnView() {
        let aViewNav = ViewNavBar()
        aViewNav.setNavBar(strTitle: "FeedBack Form", btnLeft: false, sourceController: self, btnImgName: "") { (keyPressed) in
            if keyPressed == "back"
            {
            self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func registerTableCell() {
        
        let aCellNib = UINib(nibName: strTableCellIdentifier, bundle: Bundle.main)
        tblView.register(aCellNib, forCellReuseIdentifier: strTableCellIdentifier)   
    }
    
    func getQuestionDataFromBundle() {
        
        json.getQuestionDataFromBundle()
        json.getAnswerDataFromBundle()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: button actions
    @objc func btnAnswerNowClicked(sender : UIButton)
    {
        if AppConstant.IS_IPAD
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            vc.objQuestions = json.arrQuestionResponse[sender.tag]
            //change properties of the view controller
            vc.view.backgroundColor = UIColor.white
            //present from a view and rect
            vc.modalPresentationStyle = .popover //presentation style
            present(vc, animated: true, completion: nil)
            vc.popoverPresentationController?.sourceView = view
            vc.popoverPresentationController?.sourceRect = sender.frame
        }else{
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            viewController.objQuestions = json.arrQuestionResponse[sender.tag]
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    func AddFloatingButtonOnView() {
        RemoveFloatingButtonFromWindow()
        let floatingButtonView = AddButtonView()
        floatingButtonView.tag = 1500;
        floatingButtonView.layer.cornerRadius = floatingButtonView.frame.size.width / 2
        floatingButtonView.setFloatingTable(mainView: self.view,
                                            
                                            btnWidth: AppConstant.IS_IPAD ? Int(floatingButtonView.frame.size.width+30): Int(floatingButtonView.frame.size.width),
                                            tblCellHeight: AppConstant.IS_IPAD ? 70 : 50,
                                            btnFloatingxPos: Int(floatingButtonView.frame.origin.x),
                                            btnFloatingyPos: Int(floatingButtonView.frame.origin.y),
                                            animationDelay: 0.1,
                                            withCompletionBlock:
            {(selectedValue) in
                self.RemoveFloatingButtonFromWindow()
                let lastDict = json.arrQuestionResponse.last
                let intId = lastDict?.id
                var newQuestion = Questions()
                newQuestion.id = intId!+1
                newQuestion.type = selectedValue;
                DispatchQueue.main.async {
                    print("newQ",newQuestion)
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "AddQuestionVC") as! AddQuestionVC
                    viewController.objQuestions = newQuestion
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
                
        })
        self.view.addSubview(floatingButtonView)
    }
    func  RemoveFloatingButtonFromWindow()
    {
        if  self.view.viewWithTag(1500) != nil
        {
            self.view.viewWithTag(1500)?.removeFromSuperview()
        }
    }
    
}
extension QuestionsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let aDictValue = json.arrQuestionResponse[section]
        switch aDictValue.type {
        case contentType.checkbox.rawValue, contentType.radio.rawValue:
            return aDictValue.arrAnswer.count
        default:
            if aDictValue.Answer != "" {
                return 1
            }else{return 0}
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return json.arrQuestionResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aDictValue = json.arrQuestionResponse[indexPath.section]
        let aDictAnswer = aDictValue.arrAnswer
        
        let cell = tblView.dequeueReusableCell(withIdentifier: strTableCellIdentifierAnswer, for: indexPath) as! TblCellAnswer
        if aDictAnswer.count>0{
            cell.setAnswerinsideCell(intValue: aDictAnswer[indexPath.row] )
        }else{
            cell.lblValue.text = aDictValue.Answer
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: strTableCellIdentifier) as! TblCellDataListing
        let aDictValue = json.arrQuestionResponse[section]
        cellHeader.setQuestionsDatainsideCell(dictValue: aDictValue)
        cellHeader.btnDetail.tag = section
        cellHeader.btnDetail.addTarget(self, action:#selector(btnAnswerNowClicked(sender:)) , for: .touchUpInside)
        return cellHeader.contentView
    }    
}

extension QuestionsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  AppConstant.IS_IPAD ? 60 : UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppConstant.IS_IPAD ? 75 : 25
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return AppConstant.IS_IPAD ? 100 : 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return AppConstant.IS_IPAD ? 120 : UITableViewAutomaticDimension
    }
    
}
