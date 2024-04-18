//
//  ViewController.swift
//  Contact
//
//  Created by Viktor Kizera on 16.04.2024.
//

import UIKit

class ViewController: UIViewController {
    private var constacts: [ConstactProtocol] = [] {
        didSet {
            constacts.sort{ $0.title < $1.title }
        }
    }
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadContacts()
    }
    @IBAction func showNewContactAlert() {
        let alertController = UIAlertController(title: "Створити новий контакт", message: "Введіть імʼя та номер телефону", preferredStyle: .alert)
        alertController.addTextField(){ textField in
            textField.placeholder = "Імʼя"
        }
        alertController.addTextField(){ textField in
            textField.placeholder = "Телефон"
        }
        let createButton = UIAlertAction(title: "Створити", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text, let contactPhone = alertController.textFields?[1].text else {
                return
            }
            let contact = Constact(title: contactName, phone: contactPhone)
            self.constacts.append(contact)
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Скасувати", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        self.present(alertController, animated: true, completion: nil)
    }

    func loadContacts() -> Void {
        constacts.append(
            Constact(title: "Олександр Довбняк", phone: "+380934756343"))
        constacts.append(
            Constact(title: "Інна Кізера", phone: "+380975665474"))
        constacts.append(
            Constact(title: "Христина Крижанівська", phone: "+380632345622"))
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return constacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Створюємо нову ячейку для рядка з індексом \(indexPath.row)")
            cell = reuseCell
        } else {
            print("Використовуємо стару ячейку для рядка з індексом \(indexPath.row)")
        }
        cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        configure(cell: &cell, for: indexPath)
        return cell
    }
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = constacts[indexPath.row].title
        configuration.secondaryText = constacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
    
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Видалити") { _,_,_ in
            self.constacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
