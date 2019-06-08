//
//  ViewController.swift
//  marubatuApp
//
//  Created by 梶原敬太 on 2019/06/08.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showQuestion()
        // Do any additional setup after loading the view.
    }

    //上のラベル
    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    
    //問題 Anyはなんの型でもOKってこと 配列と辞書のミックス
    let questions: [[String:Any]]=[
    
        [
            "question": "iPhoneアプリを開発する統合環境はZcodeである",
            "answer": false
        ],
        [
            "question": "Xcode画面の右側にはユーティリティーズがある",
            "answer": true
        ],
        [
            "question": "UILabelは文字列を表示する際に利用する",
            "answer": true
        ]
        
    ]
    
    
//定数question に questions配列の0番目の"question"をよびだしてquestionLabel.textに表示
    func showQuestion(){
        let question = questions[currentQuestionNum]
        if let que = question["question"] as? String{
           questionLabel.text = que
        }
    }
    
    // 回答をチェックする関数
    // 正解なら次の問題を表示します
/*checkAnswerという関数を定義
    yourAnserはBool型
     定数questionにquestions配列の0番目を入れてやる
     もし*/
    func checkAnswer(yourAnser: Bool){
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool{
            
            if yourAnser == ans{
//                ture正解
                currentQuestionNum += 1
                showAlert(message: "正解")
                
                
            }else {
                showAlert(message: "不正解")
            //foulse
                }
            //答えがなかった場合やBool値じゃなかった場合の回避
            }else {
                print("答えがありません")
                return
            }
        
//        問題番号がquestions配列の問題数以上なら0番目(1問目)に戻す
        if currentQuestionNum >= questions.count{
            currentQuestionNum = 0
        }
        
        showQuestion()
    }
    
//    アラートの関数
    func showAlert(message: String){
//        アラートの型
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
//        閉じるボタンを表示
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    
    //✗ボタン falseが正解
    @IBAction func tappNoButton(_ sender: Any) {
        checkAnswer(yourAnser: false)
    }
    
    //丸ボタン trueが正解
    @IBAction func tappYesButton(_ sender: Any) {
        checkAnswer(yourAnser: true)
    }
    
    
    
    
}

