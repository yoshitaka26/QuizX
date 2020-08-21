//
//  ShareQuizViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/06/09.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase


class ShareQuizViewController: UIViewController {
    
    let db = Firestore.firestore()
    var quizDataFSBrain = QuizDataFSBrain()
    var newQuizArray: [QuizSet] = []
    var qNum: String = ""
    var myQuizNumberArray = [String]()
    
    var newQuizDocId: [String] = []
    
    @IBOutlet weak var quizNumber: UITextField!
    @IBOutlet weak var numberOfQuiz: UILabel!
    
    override func viewDidLoad() {
        numberOfQuiz.text = String(newQuizArray.count)
        if newQuizArray.count > 99 {
            alertForQuizCountsOver()
        }
        
        fetchMyQuizNumber()
        getDocumentID()
        
    }
    
    
    @IBAction func shareQuizButton(_ sender: UIButton) {
        if let qNumber = quizNumber.text {
            if myQuizNumberArray.contains(qNumber) {
                alertForUsedNumber()
            } else {
                if let quizNumber = Int(qNumber) {
                    if newQuizArray.count > 9 {
                        if let email = Auth.auth().currentUser?.email {
                            qNum = String(quizNumber)
                            let qName = email + "_" + String(quizNumber)
                            quizDataFSBrain.recodeNewQuizToFS(quizName: qName, newQuiz: newQuizArray)
                            
                            let formatter = DateFormatter()
                            formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
                            let dateToday = formatter.string(from: Date())
                            
                            db.collection("myQuiz").addDocument(data: [
                                "flag": true,
                                "date": dateToday,
                                "email": email,
                                "myQuizName": qName,
                                "myQuizNum": String(quizNumber),
                                "totalQuizNum": newQuizArray.count]) { (error) in
                                    if let e = error {
                                        print("There was an issue saving data to firestore. \(e)")
                                    } else {
                                        print("Successfully saved data")
                                    }
                            }
                            alertForCompleteShareQuiz()
                        }
                    } else {
                        alertForQuizCounts()
                    }
                } else {
                    alertForQuizNumber()
                }
            }
        }
    }
    
    func fetchMyQuizNumber() {
        
        if let email = Auth.auth().currentUser?.email {
            db.collection("myQuiz").addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print("There was an issue retrieving data from Firebase \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let flag = data["flag"] as? Bool, let qEmail = data["email"] as? String {
                                if flag && qEmail == email {
                                    if let myQuizNum = data["myQuizNum"] as? String {
                                        self.myQuizNumberArray.append(myQuizNum)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getDocumentID() {
        
        if let email = Auth.auth().currentUser?.email {
            db.collection(email).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.newQuizDocId.append(document.documentID)
                    }
                }
            }
        }
    }
    
    func deleteAllQuizFromFS() {
        if newQuizDocId.isEmpty == false {
            if let email = Auth.auth().currentUser?.email {
                for id in newQuizDocId {
                    db.collection(email).document(id).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: - Alert
    
    func alertForCompleteShareQuiz() {
        
        let alert = UIAlertController(title: "クイズ番号『\(qNum)』で\nクイズがシェアされました", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.alertForDeletQuiz()
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertForDeletQuiz() {
        let alert = UIAlertController(title: "シェア済みのクイズを\n削除しますか？", message: "", preferredStyle: .alert)
        
        let actionYes = UIAlertAction(title: "残す", style: .default) { (action) in
            self.performSegue(withIdentifier: "ToCreateQuizMain", sender: self)
        }
        
        let actionNo = UIAlertAction(title: "消去", style: .destructive) { (action) in
            self.deleteAllQuizFromFS()
            self.performSegue(withIdentifier: "ToCreateQuizMain", sender: self)
        }
        
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertForQuizCounts() {
        
        let alert = UIAlertController(title: "クイズの数が足りません", message: "10問以上必要です", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertForQuizCountsOver() {
        
        let alert = UIAlertController(title: "クイズの数が多すぎます", message: "100問未満で作成してください", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertForQuizNumber() {
        
        let alert = UIAlertController(title: "クイズ番号は数字のみ有効です", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertForUsedNumber() {
        
        let alert = UIAlertController(title: "この番号はすでにMyQuizにシェアされています", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
