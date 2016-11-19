//
//  bairrosViewController.swift
//  projetoDeBloco - danielBraga
//
//  Created by TechReviews on 9/28/16.
//  Copyright © 2016 Braga.ltda. All rights reserved.
//

import UIKit

class bairrosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    
    @IBOutlet var bairrosTableView: UITableView!
    
    
    var bairrosArray = [String]()
    
    var bairrosPass:String!
    
    var pontosArray:[[String:String]]?
    
    var arrayDeImage = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Bairros"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        if let bundlePath = Bundle.main.path(forResource: "Property List", ofType: "plist"){
            
            if let dicionario = NSDictionary(contentsOfFile: bundlePath) {
                pontosArray = dicionario["pontosTuristicos"] as? [[String:String]]
                bairrosTableView.reloadData()
            }
        }
        
        for index in 0..<pontosArray!.count {
            
            if !bairrosArray.contains(pontosArray![index]["bairro"]!) {
                
                bairrosArray.append(pontosArray![index]["bairro"]!)
                
            }
        }
        
        bairrosArray.removeLast()
        
        bairrosArray.sort{$0 < $1}
        
        arrayDeImage = ["altoDaBoaVistaC.jpg", "campoAfonsoC", "centroC", "copacabanaC", "flamengoC", "ipanemaC", "jardimBotanicoC", "lagoaC", "lapaC", "maracanaC", "SaoCristovaoC", "UrcaC"]
        
    } //viewDidLoad End

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (bairrosArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bairroCell", for:  indexPath as IndexPath) as! BairroCell
        
        let bairroTxt:String = bairrosArray[indexPath.row]
        cell.bairroCellLugarLabel.text = bairroTxt
        cell.bairroCellImage.image = UIImage(named: arrayDeImage[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.bairrosPass = bairrosArray[indexPath.row]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = self.bairrosTableView.indexPathForSelectedRow
        let passando:PTViewController = segue.destination as! PTViewController
        passando.pontosArrayPT = pontosArray as NSArray?
        passando.bairrosPass = bairrosArray[index!.row]
    }
    
    
    /*
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destiny:PTViewController = segue.destination as! PTViewController
        destiny.bairrosPass = "test"
    }
    
   func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let index = bairrosTableView.indexPathForSelectedRow {
            let passing = segue.destination as! PTViewController
            passing.bairrosPass = "test"
            passing.pontosArrayPT = [1,2]
        }
       
        
    }*/
    
    
    


    

} // class End
