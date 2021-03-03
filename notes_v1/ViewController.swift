//
//  ViewController.swift
//  notes_v1
//
//  Created by xcode on 2/17/21.
//  Copyright © 2021 elBytes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @objc func addNote(){
        if table.isEditing{
            return
        }
        let name:String = "item \(data.count + 1)"
        data.insert(name, at: 0)
        let indexPath:IndexPath =  IndexPath(row:0, section:0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        //save()
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        save()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let detailView :DetailViewController = segue.destination as! DetailViewController
        selectedRow = table.indexPathForSelectedRow!.row
        detailView.masterView =  self
        detailView.setText(t: data[selectedRow])
    }
    
    func save(){
        UserDefaults.standard.set(data, forKey: "notes")
    }
    
    func load(){
        if let loadedData: [String] = UserDefaults.standard.value(forKey: "notes") as? [String]
        {
            data = loadedData
            table.reloadData()
        }
    }
    
    
    @IBOutlet weak var table: UITableView!
    var data:[String] = ["Item 1", "Item 2", "Item 3"]
    var selectedRow:Int = -1
    var newRowText:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addBtn
        self.navigationItem.leftBarButtonItem = editButtonItem
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1{
            return
        }
        data[selectedRow] = newRowText
        if newRowText == ""{
            data.remove(at: selectedRow)
        }
        table.reloadData()
        save()
    
    }
    


}

