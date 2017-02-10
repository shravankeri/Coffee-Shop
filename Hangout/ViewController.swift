//
//  ViewController.swift
//  TheHangouts
//
//  Created by Shravan Keri on 09/02/17.
//  Copyright © 2017Shravan Keri. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let locationHelper = THLocationHelper.sharedInstance
    var coffeeShops: [Any]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Hangouts"
        self.tableView.register(UINib.init(nibName: "THCafeTableCell", bundle: nil), forCellReuseIdentifier: "CafeCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44;
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.refetchNearbyCoffeeshops), name: NSNotification.Name(rawValue: "locationdidupdate"), object: nil);
        
    }
    
    func refetchNearbyCoffeeshops() {
        let latitude: Double = (locationHelper.currentLocation?.coordinate.latitude)!
        let longitude: Double = (locationHelper.currentLocation?.coordinate.longitude)!;
        THAPIHelper.sharedInstance.fetchNearbyCafes(latitude: latitude, longitude: longitude) { (res, data) in
            if res == true {
                THCoffeeShop.parseData(data: data, completionHandler: { (shopsArray) in
                    self.coffeeShops = shopsArray.sorted(by: { ($0 as! THCoffeeShop).distance! < ($1 as! THCoffeeShop).distance! })
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDatasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( coffeeShops.count);
        return coffeeShops.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: THCafeTableCell = tableView.dequeueReusableCell(withIdentifier: "CafeCell") as! THCafeTableCell;
        
        let shop: THCoffeeShop = self.coffeeShops[indexPath.row] as!THCoffeeShop
        
        cell.nameLabel.text = shop.name
        cell.addressLabel.text = shop.address
        cell.distanceLabel.text = String(format:"%.1f km", shop.distance!/1000)
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shop: THCoffeeShop = self.coffeeShops[indexPath.row] as!THCoffeeShop
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "THCompanyWebsiteVC") as! THCompanyWebsiteVC
        vc.weburl = shop.website;
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

