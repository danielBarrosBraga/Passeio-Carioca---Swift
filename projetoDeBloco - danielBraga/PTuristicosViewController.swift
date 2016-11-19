//
//  PTuristicosViewController.swift
//  projetoDeBloco - danielBraga
//
//  Created by TechReviews on 9/28/16.
//  Copyright © 2016 Braga.ltda. All rights reserved.
//

import UIKit

class PTuristicosViewController: UIViewController {
    

    @IBOutlet var tableView: UITableView!
    
    var pontosArrayPT:NSArray?
    
    var bairrosPass:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = bairrosPass {
            pontosArrayPT = pontosArrayPT?.filtered(using: NSPredicate(format:"bairro = %@",bairrosPass!)) as NSArray?
        }
        else {
            if let bundlePath = Bundle.main.path(forResource: "Property List", ofType: "plist"){
                if let dicionario = NSDictionary(contentsOfFile: bundlePath) {
                    pontosArrayPT = dicionario["pontosTuristicos"] as? NSArray
                    tableView.reloadData()
                }
            }
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(pontosArrayPT?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
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
    

}
