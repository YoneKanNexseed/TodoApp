//
//  Todo.swift
//  TodoApp
//
//  Created by yonekan on 2019/03/13.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
// Realmの部品を使いたいので、使える状態にする
import RealmSwift

// エクセルのシート
// シート名「Todo」
// id, title, dateが列のタイトル

class Todo: Object {
    // ID
    @objc dynamic var id: Int = Int()
    
    // タイトル
    @objc dynamic var title: String = String()
    
    // 作成日付
    @objc dynamic var date: String = String()
    
    // Todoを追加する関数
    // 引数titleにtextField.textの値が入ってくる想定
    func create(title: String) {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let realm = try! Realm()
        
        // この中でシートに書き込みを行う
        try! realm.write {
            let todo = Todo()

            // 最大IDを取得する。何もデータが無かったら0を設定する
            let maxId = (realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0)
            
            // 現在の日付を取得する
            let now = Date()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            
            todo.id = maxId + 1
            todo.title = title
            todo.date = formatter.string(from: now)
            
            realm.add(todo)
        }
        
    }
    
    // Todoを全件取得して、返す
    func findAll() -> [Todo] {
        // Realmの準備
        let realm = try! Realm()
        
        // realm.objects(全件取得したいクラス名.self)
        // 全件取得
        let todoCollection = realm.objects(Todo.self)
        
        let todos: [Todo] = todoCollection.reversed()
        
        return todos
    }
    
    
    // 編集する関数
    func update(todo: Todo, newTitle: String) {
        let realm = try! Realm()
        
        // 編集対象のTodoを取得する
        let targetTodo = findById(id: todo.id)
        
        try! realm.write {
            targetTodo.title = newTitle
        }
    }
    
    // IDを指定してTodoを取得する
    func findById(id: Int) -> Todo {
        let realm = try! Realm()
        
        // Todoの一覧からIDが一致するTodoを取得する
        let todo = realm.objects(Todo.self).filter("id = \(id)").first
        return todo!
    }
    
}
