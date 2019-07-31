//
//  InputViewController.swift
//  ToDoProject
//
//  Created by 香川紗穂 on 2019/07/30.
//  Copyright © 2019 香川紗穂. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {
    
//   ① つなげる
    @IBOutlet weak var textField: UITextField!
    
//    前の画面から渡されてきたtodoを受け取る変数
    var todo: Todo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
// 選択　二本指　リファクター　methodで長くなったメソッドを見やすく！
    fileprivate func createTodofunc(_ text: String) {
        // realmに接続
        let realm = try! Realm()
        
        
        //③空文字でなければ、データを登録する
        //        まずは実態を作る
        let todo = Todo()
        //        idの列から、最大のidをとってきて、そのid+1にデータを登録したい
        let id = getMaxId()
        
        todo.id = id
        todo.title = text
        todo.date = Date()
        
        //       ④ 作成したTODOを登録する
        try! realm.write {
            realm.add(todo)
        }
    }
    
    
    @IBAction func didClickButton(_ sender: UIButton) {
//②登録する前に、空文字かどうかをチェックする
        // if textField.text == ""{  な書き方でもいいけど
//        if textField.text!.isEmpty   nilだったら怒られる
        
        
        
////         そこで、オプショナルバインディングでtextField.textがnilかチェックする
//        if let title = textField.text {
////         nilでない場合
//        if title.isEmpty{
////          空文字でない場合
//            }
//        }
        
//上のコメントアウトのやり方でも、{}がいっぱいになってわかりにくい
//②そこでさらに、違う書き方あるよ！   guard let構文
        guard let text = textField.text else{
//                textField.textがnilの場合、ボタンがクリックされた時の処理を中断する
//                if let と逆で、nilfあった場合に実行される
            return
        }
        
        if text.isEmpty{
//            このtextに入ってくるのは　 guard let textのtext
//            textField.textが空文字の場合、ボタンがクリックされた時の処理を中断する
            return
        }
       
        
        
//        新規タスクを追加
        createTodofunc(text)
        
//        前の画面に戻る
//        navigationControllerの持っている履歴から一つ前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
        
    
    
//        三項演算子を使うとこうなる................は？
//        let id = (realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0) + 1
        func getMaxId() -> Int{
        let realm = try! Realm()
//       TOdoシートから最大のIDを取得する
        let id = realm.objects(Todo.self).max(ofProperty: "id")as Int?
//            maxはでっかい枠組み　　その中からas Int? Intで！、そして、？でinlも許容（最初はデータ0やから）
            if id == nil{
//         最大idがnil（存在しない）場合、1を返す
//                処理を中断しつつ　１を返す！
                return 1
            }else{
//          最大IDが存在する場合、最大ID + 1を返す
                return id! + 1
            }
        }
    

}
