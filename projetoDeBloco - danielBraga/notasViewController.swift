//
//  notasViewController.swift
//  projetoDeBloco - danielBraga
//
//  Created by TechReviews on 10/7/16.
//  Copyright © 2016 Braga.ltda. All rights reserved.
//

import UIKit
import CoreData

class notasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func adicionarNota(_ sender: AnyObject) {
        alert()
    }
    
    @IBOutlet var notasTableView: UITableView!
    
    var notasArray: [NotaEntity] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notasTableView.dataSource = self
        notasTableView.delegate = self
        self.getData()
        notasTableView.rowHeight = UITableViewAutomaticDimension
        notasTableView.estimatedRowHeight = 100.0
        notasTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notasArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notaId") as! NotasCell
        let nota = notasArray[indexPath.row]
        cell.notaLabel.text = nota.item!
        return cell
    }
    
    
    func alert() {
        let alert = UIAlertController(title:"Digite seu lembrete", message:"", preferredStyle: .alert)
        
        alert.addTextField {
            (textfield) in textfield.placeholder = "..."
        }
        
        let add = UIAlertAction(title: "Adicionar", style: .default) {
            (action) in
            let textfield = (alert.textFields?[0])!
            
            let dataNota = NotaEntity(context: self.context)
            
            dataNota.item = textfield.text!
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
            self.getData()
            
            self.notasTableView.reloadData()
            
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) {
            (alert) in
        }
        
        alert.addAction(add)
        alert.addAction(cancel)
        
        present(alert, animated:true, completion: nil)

    }
    
    func getData() {
        
        do {
            notasArray = try context.fetch(NotaEntity.fetchRequest())
        } catch {
            print("Erro no Fetch")
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let nota = notasArray[indexPath.row]
            context.delete(nota)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                notasArray = try context.fetch(NotaEntity.fetchRequest())
            } catch {
                print("Erro no Fetch")
            }
            
        }
        
        notasTableView.reloadData()
    }
    

}
