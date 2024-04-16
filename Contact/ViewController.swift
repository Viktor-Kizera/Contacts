//
//  ViewController.swift
//  Contact
//
//  Created by Viktor Kizera on 16.04.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
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
        configuration.text = "Рядок \(indexPath.row)"
        cell.contentConfiguration = configuration
    }
    
}

