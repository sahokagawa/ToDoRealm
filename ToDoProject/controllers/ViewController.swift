//
//  ViewController.swift
//  ToDoProject
//
//  Created by 香川紗穂 on 2019/07/30.
//  Copyright © 2019 香川紗穂. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
//    TOdo型の配列
    var todos:[Todo] = []
    
    
    
    fileprivate func reloadTableView() {
        //Realmに接続
        let realm = try! Realm()
        //todoの一覧を取得する
        todos = realm.objects(Todo.self).reversed()
        //テーブルを更新
        tableView.reloadData()
    }
    
//    画面が作られた時の最初の一回だけ実行
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
//    viewWillAppearは画面が表示されるたびに実行  viewDidLoad()とは違って！
//    表示されるたびに、最新のデータとって表示してほしい
    override func viewWillAppear(_ animated: Bool) {
       reloadTableView()
    }


    @IBAction func didClickAddButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toNext", sender: nil)
    }
    
}



extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
//        titleを取り出して、セルのラベルに表示
        
//編集したい
//        セルに矢印をつける
        cell.accessoryType = .disclosureIndicator
        return cell
    }
//編集したい
//セルがクリックされた時の処理
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        選択されたtodoを取得して編集できるところに
        let todo = todos[indexPath.row]
        performSegue(withIdentifier: "toNext", sender: todo)
        
//        渡した以上、受け取る側にも処理が必要！inputViewControllerに箱作る
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNext" {
//            次の画面のコントローラー取得
            let inputVC = segue.destination as! InputViewController
//            次の画面の選択されたTodoを設定
            inputVC.todo = sender as? Todo
        }
    }
    
}
