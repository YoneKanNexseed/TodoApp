//
//  AddViewController.swift
//  TodoApp
//
//  Created by yonekan on 2019/03/13.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    // 一覧の画面で選択されたTODOが入ってくる
    var todo: Todo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 一覧画面でTODOが選択されている場合
        if todo != nil {
            // ボタンのタイトルを変更する
            button.setTitle("編集", for: .normal)
            
            textField.text = todo?.title
        }
    }
    
    // 追加ボタンの処理
    @IBAction func add(_ sender: UIButton) {
        
        let realmTodo = Todo()
        
        if todo == nil {
            // 追加の場合
            realmTodo.create(title: textField.text!)
        } else {
            // 編集の場合
            realmTodo.update(todo: todo!, newTitle: textField.text!)
        }
        
        
    }
    
}
