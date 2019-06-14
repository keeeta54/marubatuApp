//
//  addViewController.swift
//  marubatuApp
//
//  Created by 梶原敬太 on 2019/06/09.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit


class addViewController: UIViewController,UITextFieldDelegate{
    //問題入力
    @IBOutlet weak var textField: UITextField!
    //◯か✗か
    @IBOutlet weak var maruOrbatu: UISegmentedControl!
    
    //問題と答えの配列
    var questions: [[String: Any]] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲートを使うため
        textField.delegate = self//画面が読み込まれた時にデータを配列に保存
        if UserDefaults.standard.object(forKey: "questions") != nil {
            questions = UserDefaults.standard.object(forKey: "questions") as! [[String : Any]]
            //チェック
            print("追加画面ロード時:\(questions)")
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
   
    
    
    //前のページへ戻るボタン
    @IBAction func tophemodoru(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //問題保存ボタン
    @IBAction func hozon(_ sender: UIButton) {
        
        //問題が入力されなかったとき
        if textField.text == "" {
            showAlert(message: "問題を追加してください")
            
        //問題が入力されたとき
        }else {
            //入力されたものを変数に格納
            var question = textField.text!
            
            //答えが入るBool型の変数
            var marubatsuAnswer: Bool = true
            
            //もしSegmentedControlで✗(左側)が選ばれているとき(インデックスが0番の時)は
            if maruOrbatu.selectedSegmentIndex == 0 {
                
                //答えの変数marubatsuAnswerはfalseが答えになる
                marubatsuAnswer = false
            } else {
                //✗以外のとき(◯が選ばれたとき、インデックス番号が0以外の時)答えはtrueになる
                marubatsuAnswer = true
            }
            
            //答えが決まったらquestions配列に追加する 問題文はquestion 答えはmarubatsuAnswer に入っている
            //var questions: [[String: Any]] = []
            questions.append(["question": question, "answer": marubatsuAnswer])
            
            //追加したら入力画面は空にする
            textField.text = ""
            
            //UserDefaults.standardで  変数userDefaults は UserDefaultsのデータを参照しますよということ
            //データを保存する時やデータを取り出す時など様々な場面で登場する
             let userDefaults = UserDefaults.standard
            
            //問題が追加された配列をユーザーデフォルトにquestionsというキー値で保存する
            //userDefaults.set(保存したいデータ(今回は配列), forKey: “キー名”)
            userDefaults.set(questions, forKey: "questions")
            
            //シュミレータで動かしたときにデバックエリアでなにが保存されてるか見るために配列をprintしてみる
            print("保存したデータ\(questions)")
        }
        
    }
    
    
    
    
    //削除ボタン
    @IBAction func allDerete(_ sender: UIButton) {
        //UserDefaults.standardで  UserDefaultsのデータを参照しますよということ
        let userDefaults = UserDefaults.standard
        
        //.removeObject で全削除
        userDefaults.removeObject(forKey: "questions")
        
         //userDefaults.set  で userDefaultsに空の配列を保存する
        userDefaults.set([], forKey: "questions")
        questions = []
        print("配列\(questions)")
        showAlert(message: "削除完了")
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


