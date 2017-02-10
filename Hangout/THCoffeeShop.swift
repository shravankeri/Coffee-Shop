//
//  THCoffeeShop.swift
//  TheHangouts
//
//  Created by Shravan Keri on 10/02/17.
//  Copyright © 2017 Shravan Keri. All rights reserved.
//

import Foundation

class THCoffeeShop {
    
    var name: String?
    var address: String?
    var distance: Double?
    var latitude: Double?
    var longitude: Double?
    var website: String?
    
    class func parseData(data: Any, completionHandler: ([Any]) -> ()) {
        let dictionary = data as! [String:Any]
        let response = dictionary["response"] as! [String: Any]
        let venues = response["venues"] as! [Any]
        
        var coffeeshops : [THCoffeeShop] = []
        for venue in venues {
            let shop = THCoffeeShop()
            let ven = venue as! [String: Any]
            shop.name = ven["name"] as! String?
            let location = ven["location"] as! [String:Any]
            shop.address = location["address"] as! String?
            shop.latitude = location["lat"] as! Double?
            shop.longitude = location["lng"] as! Double?
            shop.website = ven["url"] as! String?
            
            shop.distance = THLocationHelper.sharedInstance.getDistanceof(lat: shop.latitude!, long: shop.longitude!)
            
            coffeeshops.append(shop)
        }
        print(coffeeshops)
        completionHandler(coffeeshops)
    }
}
