//
//  JsonData.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import Foundation
class JsonData
{
    var arrQuestionResponse = [Questions]()
    var arrAnswerResponse = [Answer]()
    
    func getAnswerDataFromBundle() {
        ParseJson().ParseJsonFile(fileName: "Answers") { (arrFetchData) in
            for aData in arrFetchData{
            let aAnswer = Answer(id:aData["id"] as! Int, value:aData["value"] as! String)
                self.arrAnswerResponse.append(aAnswer)
            }
        }
    }
    
    func getQuestionDataFromBundle() {
        
        ParseJson().ParseJsonFile(fileName: "questionnaire") { (arrFetchData) in
            for aData in arrFetchData{
                let arrOption = aData["arrOption"] as? [Any]
                let arrAnswers = aData["arrAnswer"] as? [Any]
                let aQuestion = Questions(id: aData["id"] as! Int, type: aData["type"] as! String, question: aData["question"] as! String, Answer: aData["Answer"] as! String, arrOption:arrOption as! [Int], arrAnswer: arrAnswers as! [Int])
                self.arrQuestionResponse.append(aQuestion)
            }
//            print("Response : \(self.arrQuestionResponse)")
        }
    }
}
