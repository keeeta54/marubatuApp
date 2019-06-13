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

    //問題表示のラベル
    @IBOutlet weak var questionLabel: UILabel!
    
    // 問題を出すときに配列から問題番号を呼び出すときに使用する変数
    var currentQuestionNum: Int = 0
    
    //問題と答えの配列 Anyはなんの型でもOKってこと 配列と辞書のミックス 配列の中に辞書をいれている
    var questions: [[String:Any]] = []
    
     let userDefaults = UserDefaults.standard
    
    
    //    viewDidLoad：インスタンス化された直後（初回に一度のみ）
    // ***viewWillAppear：画面が表示される直前***
    //    viewDidAppear：画面が表示された直後
    //    viewWillDisappear：別の画面に遷移する直前
    //    viewDidDisappear：別の画面に遷移した直後
    
//    addviewcontrollerで問題を登録して画面遷移してきたときに
//    キーを頼りに[questions配列] にデータを保存
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //画面が戻って来たときに一旦配列を空にしてから再度読み込む
        questions = []
        
        //userDefaults.object(forKey: “キー名”)はデータを取り出すメソッド。
        //forKey に userDefaults.setメソッドで設定したキー値をいれて、データを取り出す。
        if userDefaults.object(forKey: "questions") != nil {
            
            //もしデータが入っていたらquestions配列にデータを入れる
            questions = userDefaults.object(forKey: "questions") as! [[String: Any]]
            
        showQuestion()
        }
    }
    
    
    
    //問題を表示
    func showQuestion(){
        // 問題が残っていたら
        if (questions.count > currentQuestionNum){
            
            //定数questionにquestions配列に入っているcurrentQuestionNum◯番目を代入
            let question = questions[currentQuestionNum]
           
            // 配列で[String:Any]のAnyにしたことでStringと定義しないといけない それで「as? String」を使う
            //定数queに問題文を入れる
            if let que = question["question"] as? String {
              
              //ラベルに問題数と問題文を表示する。配列は0から始まるからcurrentQuestionNum+1で"1問目"から始まる
                questionLabel.text = "\(currentQuestionNum+1)問目: " + que
            }
            
        } else {
            // 問題が入っていない時にはエラーメッセージ
            questionLabel.text = "問題を作成してください"
        }
    }
    
    
    
    
    
    // 回答をチェックする関数
    //もしquestions配列の○番目のanswerがyouranserと一緒なら問題番号に+1して正解というアラートを表示
    func checkAnswer(yourAnser: Bool){
        
        //定数questionにquestions配列に入っているcurrentQuestionNum◯番目を代入
        let question = questions[currentQuestionNum]
        
        //questonという配列のなかの"answer"を取り出して、ansという定数に格納する
        let ans = question["answer"] as? Bool
        //正解なら次の問題へ
        if yourAnser == ans{
            currentQuestionNum += 1
            showAlert(message: "正解")
        }else {
            //不正解なら次にはいかない
            showAlert(message: "不正解")
        }
        
        //問題番号(0から始まる)が問題数以上になったら0番目(1問目)に戻す
        if currentQuestionNum >= questions.count{
            currentQuestionNum = 0
        }
        //問題を表示する関数
        showQuestion()
    }
    
    
        //アラートの関数
    func showAlert(message: String){
        
        // アラートの型
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        // 閉じるボタンを表示
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

