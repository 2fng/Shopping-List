//
//  ViewController.swift
//  Challenge2
//
//  Created by Hua Son Tung on 10/12/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Shopping List".uppercased()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Add items button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = addButton
        
        //Clear List
        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearItem))
        navigationItem.leftBarButtonItem = clearButton
    }
    
    //MARK: -BarButton functions
    @objc func addItem() {
        let alertController = UIAlertController(title: "Please enter item's name and quantity", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addTextField()
        
        alertController.textFields?[0].placeholder = "Name"
        alertController.textFields?[1].placeholder = "Quantity"
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] action in
            guard let textField1 = alertController?.textFields?[0].text else { return }
            guard let textField2 = alertController?.textFields?[1].text else { return }
            let item = "\(textField1) x\(textField2)"
            self?.submit(item: item)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func clearItem() {
        let alertController = UIAlertController(title: "Are you sure you want to clear the list?", message: nil, preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self] action in
            self?.shoppingList = []
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func submit(item: String) {
        shoppingList.insert(item, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    //MARK: -Tableview datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingList", for: indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }


}

