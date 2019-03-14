//
//  ViewController.swift
//  TodoApp
//
//  Created by yonekan on 2019/03/13.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Todoを全件保持する変数
    var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        // 全件Todoを取得
        let todo = Todo()
        todos = todo.findAll()
        
        // テーブルを更新
        tableView.reloadData()
    }
    
    // テーブルの行数設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let todo = todos[indexPath.row]
        
        cell.textLabel?.text = todo.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // withIdentifier: 矢印の名前
        // sender: 次の画面に渡したい値
        
        let todo = todos[indexPath.row]
        performSegue(withIdentifier: "toAddVC", sender: todo)
    }
    
    // 画面遷移する時に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAddVC" {
            // 矢印の名前がtoAddVCの場合
            // 次の画面に選択されたTODOを設定する
            let addVC = segue.destination as! AddViewController
            addVC.todo = sender as? Todo
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

