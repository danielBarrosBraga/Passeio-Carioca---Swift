//
//  DetalheViewController.swift
//  projetoDeBloco - danielBraga
//
//  Created by TechReviews on 9/28/16.
//  Copyright © 2016 Braga.ltda. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit



class DetalheViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var detalheImage: UIImageView!
    
    @IBOutlet var detalheNomeLabel: UILabel!
    
    @IBOutlet var detalheTipoLabel: UILabel!
    
    @IBOutlet var detalheNotaLabel: UILabel!
    
    @IBOutlet var detalheInOutImage: UIImageView!
    
    @IBOutlet var detalheDescriptionLabel: UILabel!
    
    @IBOutlet var detalheAdressLabel: UILabel!
    
    @IBAction func detalheWikiLink(_ sender: AnyObject) {
        let urlP = pontoDetalhe!["wiki"] as? String
        if NSURL(string: "http://...") != nil {
            UIApplication.shared.openURL(URL(string: urlP!)!)
        }
    }
    
    var cordinateP:CLLocationCoordinate2D?
    

    

    @IBOutlet var mapView: MKMapView!
    
    var autorizacao = CLLocationManager()
    
    var pontoDetalhe:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autorizacao.delegate = self
        autorizacao.requestWhenInUseAuthorization()
        autorizacao.desiredAccuracy = kCLLocationAccuracyBest;
        autorizacao.startUpdatingLocation()
        
        autorizacao.startUpdatingHeading()
        
        mapView.showsUserLocation = true
        
        if pontoDetalhe != nil {
            
            detalheImage.image = UIImage(named: pontoDetalhe!["detalheFoto"] as! String)
            detalheNomeLabel.text = pontoDetalhe!["nome"] as? String
            detalheAdressLabel.text = pontoDetalhe!["address"] as? String
            detalheTipoLabel.text = pontoDetalhe!["tipo"] as? String
            detalheNotaLabel.text = pontoDetalhe!["nota"] as? String
            detalheInOutImage.image = UIImage(named: pontoDetalhe!["indoorOutdoor"] as! String)
            detalheDescriptionLabel.text = pontoDetalhe!["description"] as? String
            
            btActionGeoCoder()
        }

    }
    
    func btActionGeoCoder(){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(detalheAdressLabel.text!) {
            (placemarks, error) -> Void in
            if let placemark: CLPlacemark = placemarks?[0]{
                let location = placemark.location
                if let coords:CLLocationCoordinate2D = location?.coordinate{
                    
                    self.cordinateP = coords
                    
                    let region = MKCoordinateRegionMakeWithDistance(coords, 1500, 1500)
                    self.mapView.setRegion(region, animated: false)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coords
                    annotation.title = self.pontoDetalhe!["nome"] as?String
                    annotation.subtitle = self.pontoDetalhe!["address"] as?String
                    self.mapView.addAnnotation(annotation)
                }
            }
            else {
                print("Geocode falhou.Erro")
            }
        }
    }
    
    @IBAction func detalhePonta(_ sender: AnyObject) {
        if self.cordinateP != nil {
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            
            let placemark = MKPlacemark(coordinate: self.cordinateP!, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    @IBAction func minhaLocalidadeB(_ sender: AnyObject) {
        let coord = self.mapView.userLocation.coordinate
        let region = MKCoordinateRegionMakeWithDistance(coord, 1500, 1500)
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func pontoLocalidadeB(_ sender: AnyObject) {
        let region = MKCoordinateRegionMakeWithDistance(cordinateP!, 1500, 1500)
        self.mapView.setRegion(region, animated: true)
    }


}
