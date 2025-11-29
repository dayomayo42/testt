//
//  InstructionsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.06.2021.
//

import UIKit

class InstructionsController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if case let controller as InstructionsDetailController = segue.destination, segue.identifier == "innstruction" {
            controller.selectedId = tableView.indexPathForSelectedRow?.row ?? 0
        }
    }

}

extension InstructionsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnswerCell
        
        cell.answerLabel.text = "Инструкция №\(indexPath.row + 1)"
      //  cell.configure(with: list[indexPath.row])
        return cell
    }
}
