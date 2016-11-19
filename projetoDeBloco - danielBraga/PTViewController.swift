//
//  PTViewController.swift
//  projetoDeBloco - danielBraga
//
//  Created by TechReviews on 9/28/16.
//  Copyright © 2016 Braga.ltda. All rights reserved.
//


import UIKit

class PTViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var bairrosPass:String?
    
    var pontosArrayPT:NSArray?
    
    @IBOutlet var PTTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if bairrosPass != nil {
            pontosArrayPT = pontosArrayPT?.filtered(using: NSPredicate(format:"bairro = %@",bairrosPass!)) as NSArray?
            self.title = bairrosPass
        } else {
            if let bundlePath = Bundle.main.path(forResource: "Property List", ofType: "plist") {
                if let dicionario = NSDictionary(contentsOfFile: bundlePath) {
                    pontosArrayPT = dicionario["pontosTuristicos"] as? NSArray
                    PTTableView.reloadData()
                }
                self.title = "Todos"
                
            }
            
        }
        
        
    } // <--- ViewDidLoad End
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pontosArrayPT!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PTuristicosCell = tableView.dequeueReusableCell(withIdentifier: "PTCell", for: indexPath as IndexPath)as! PTuristicosCell
        
        if let place:NSDictionary = pontosArrayPT![indexPath.row] as? NSDictionary{
            cell.PTNameLabel.text = place ["nome"] as? String
            cell.PTDressLabel.text = place ["address"] as? String
            cell.PTImageView.image = UIImage(named:place["image"] as! String)
            cell.PTTipoLabel.text = place["tipo"] as? String
            cell.PTNotaLabel.text = place["nota"] as? String
            cell.PTImage2View.image = UIImage(named:place["indoorOutdoor"] as! String)

        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let  index = PTTableView.indexPathForSelectedRow {
            let detalhePass = segue.destination as! DetalheViewController
            let dictionary = pontosArrayPT![index.row] as? NSDictionary
            detalhePass.pontoDetalhe = dictionary
        }
    }
    


}
