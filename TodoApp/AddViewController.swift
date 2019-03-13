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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 追加ボタンの処理
    @IBAction func add(_ sender: UIButton) {
        let todo = Todo()
        todo.create(title: textField.text!)
    }
    
}
