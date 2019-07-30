//
//  Todo.swift
//  ToDoProject
//
//  Created by 香川紗穂 on 2019/07/30.
//  Copyright © 2019 香川紗穂. All rights reserved.
//

//import Foundation
import RealmSwift

//必ず、objectを継承させる
class Todo: Object {
//    ID（連番）
    @objc dynamic var id: Int = 0
//    タイトル
    @objc dynamic var title: String = ""
//    登録日時
    @objc dynamic var date: Date = Date()
}
