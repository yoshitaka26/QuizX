//
//  QuizDataFSBrain.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/21.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation
import Firebase

struct QuizDataFSBrain {
    
    let db = Firestore.firestore()
    var quizDataSetLoaded: [QuizDataSet] = []
    
    
    //JSONからFirestoreへ保存する
    func recodeQuizDataToFS(_ quizDataSetLoaded: [QuizDataSet], _ quizSetFileName: String) {
        for i in 0...quizDataSetLoaded.count - 1 {
            if i < 10 {
                db.collection(quizSetFileName).document("quiz0\(i)").setData([
                    "answer": quizDataSetLoaded[i].answer,
                    "dummy1": quizDataSetLoaded[i].dummy1,
                    "dummy2": quizDataSetLoaded[i].dummy2,
                    "dummy3": quizDataSetLoaded[i].dummy3,
                    "explication": quizDataSetLoaded[i].explication,
                    "question": quizDataSetLoaded[i].question
                ]) { (error) in
                    if let err = error {
                        print("Error writing document: \(err)")
                    }
                    print("Document successfully written!")
                }
            } else {
                db.collection(quizSetFileName).document("quiz\(i)").setData([
                    "answer": quizDataSetLoaded[i].answer,
                    "dummy1": quizDataSetLoaded[i].dummy1,
                    "dummy2": quizDataSetLoaded[i].dummy2,
                    "dummy3": quizDataSetLoaded[i].dummy3,
                    "explication": quizDataSetLoaded[i].explication,
                    "question": quizDataSetLoaded[i].question
                ]) { (error) in
                    if let err = error {
                        print("Error writing document: \(err)")
                    }
                    print("Document successfully written!")
                }
            }
            
        }
    }
    
    
    //Firestoreからファイルの名前でクイズデータ読み込み
    mutating func loadQuizDataFromFS(with quizSetFileName: String, completion: @escaping ([QuizSet]) -> Void) {
        
        var quizDataSetLoadedFromFS: [QuizSet] = []
        
        let quizData = db.collection(quizSetFileName)
        
        quizData.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents of quizData: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let data = document.data() as? [String: String] {
                        if let question = data["question"], let answer = data["answer"], let explication = data["explication"], let dummy1 = data["dummy1"], let dummy2 = data["dummy2"], let dummy3 = data["dummy3"] {
                            let quizSet = QuizSet(answer: answer, dummy1: dummy1, dummy2: dummy2, dummy3: dummy3, explication: explication, question: question)
                            quizDataSetLoadedFromFS.append(quizSet)
                        } else {
                            print("fail to set data to QuizSet Model")
                        }
                    }
                }
                print("Trying to load Data...")
            }
            completion(quizDataSetLoadedFromFS)
        }
    }
    
    
    //Firestoreからクイズ名（語源クイズ）を読み込み
    mutating func loadQuizDataNameFromFS(with quizDataName: String,completion: @escaping ([String]) -> Void) {
        
        let quizName = db.collection(quizDataName)
        var quizNames: [String] = []
        
        quizName.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents of quizName: \(err)")
            } else {
                for documet in querySnapshot!.documents {
                    if let name = documet.data() as? [String: String] {
                        if let quizName = name["name"] {
                            quizNames.append(quizName)
                        }
                    }
                }
            }
            completion(quizNames)
        }
    }
    
    
    func recodeNewQuizToFS(quizName: String, newQuiz: [QuizSet]) {
        for i in 0...newQuiz.count - 1 {
            if i < 10 {
                let documentName = "newQuiz0\(i)"
                
                db.collection(quizName).document(documentName).setData([
                    "answer": newQuiz[i].answer,
                    "dummy1": newQuiz[i].dummy1,
                    "dummy2": newQuiz[i].dummy2,
                    "dummy3": newQuiz[i].dummy3,
                    "explication": newQuiz[i].explication,
                    "question": newQuiz[i].question
                ]) { (error) in
                    if let err = error {
                        print("Error writing document: \(err)")
                    }
                    print("Document successfully written!")
                }
            } else {
                let documentName = "newQuiz\(i)"
                
                db.collection(quizName).document(documentName).setData([
                    "answer": newQuiz[i].answer,
                    "dummy1": newQuiz[i].dummy1,
                    "dummy2": newQuiz[i].dummy2,
                    "dummy3": newQuiz[i].dummy3,
                    "explication": newQuiz[i].explication,
                    "question": newQuiz[i].question
                ]) { (error) in
                    if let err = error {
                        print("Error writing document: \(err)")
                    }
                    print("Document successfully written!")
                }
            }
            
        }
    }
    
}



