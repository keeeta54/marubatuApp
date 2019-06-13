//
//  addViewController.swift
//  marubatuApp
//
//  Created by 梶原敬太 on 2019/06/09.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit

//問題と正解が格納される
var questions: [[String: Any]] = []

class addViewController: UIViewController,UITextFieldDelegate{
//
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var maruOrbatu: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲートを使うため？
        textField.delegate = self
        // Do any additional setup after loading the view.
    }
   
    
    
    //前のページへ戻るボタン
    @IBAction func tophemodoru(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //問題保存ボタン
    @IBAction func hozon(_ sender: UIButton) {
        
        //もし問題が空じゃなかったら
        if textField.text! != "" {
            
            var marubatsuAnswer: Bool = true
            
            //もしSegmentedControlで✗が選ばれているとき(インデックスが0番の時)は
            //変数marubatsuAnswerはfalseが答えになる
            if maruOrbatu.selectedSegmentIndex == 0 {
                marubatsuAnswer = false
            } else {
                //X以外のときはtrue  ◯が選ばれたとき
                marubatsuAnswer = true
            }
            
            //UserDefaults.standardはUserDefaultsを参照しているということ。データを保存する時やデータを取り出す時など様々な場面で登場する。
            let userDefaults = UserDefaults.standard
            
            //userDefaults.object(forKey: “キー名”)はデータを取り出すメソッド。
            //引数にsetメソッドで設定した合言葉を設定して、データを取り出す。
            //もしquestionキーで保存されてるオブジェクトがあったら
            if userDefaults.object(forKey: "questions") != nil {
                //データを読み込んで
                questions = userDefaults.object(forKey: "questions") as! [[String: Any]]
                //配列の後ろに追加
                questions.append(
                    [
                        "question": textField.text!,
                        "answer": marubatsuAnswer
                    ])
                
                
                //追加したあとに保存
                //userDefaults.set(保存したいデータ今回は配列, forKey: “キー名”)
                //データをセットするメソッド。第一引数に保存したいデータを入れて、第二引数に取り出す時に必要な合言葉を設定。
                userDefaults.set(questions, forKey: "questions")
                
                //問題が保存されたらアラートを表示してtextFieldを空にする
                showAlert(message: "問題が保存されました")
                textField.text = ""
                
                //何も保存されていないとき
            } else {
                var questions:[[String: Any]] = [] //配列を初期化
                questions.append(
                    ["question": textField.text!,
                     "answer": marubatsuAnswer
                    ])
                userDefaults.set(questions, forKey: "questions")
                showAlert(message: "問題が保存されました")
                textField.text = ""
            }
            //配列が空の場合
        } else {
            showAlert(message: "問題文を入力してください。")
        }
    }
    
    
    
    
    //削除ボタン
    @IBAction func allDerete(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        //保存されている問題と解答をすべて削除
        userDefaults.removeObject(forKey: "questions")
        /* 問題と解答を削除したので、キーが"questions"のオブジェクトの値がnilになる
         * -> 読み込まれたときのエラーを回避するために値に空の配列を入れておく
         */
        userDefaults.set([], forKey: "questions")
        showAlert(message: "問題をすべて削除しました。")
    }

    
    
    
    // アラートを出す関数
    //使うときはshowAlert(message: "表示したいメッセージ")とかけばいい
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "とじる", style: .cancel , handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}






    
    
    
    
    
    
    
    
    
    
    

    

    

    




    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


