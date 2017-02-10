//
//  THAPIHelper.swift
//  TheHangouts
//
//  Created by Shravan Keri on 09/02/17.
//  Copyright © 2017 Shravan Keri. All rights reserved.
//

import Foundation

class THAPIHelper: NSObject {
    static let sharedInstance = THAPIHelper()
    let clientid = "M5T2LVOCWNIJ0GB1EQG5BCTWSYTPD4R4D1RLYGELAZOCUWBM"
    let clientsecrete = "ROP44BIHYBA401DWWMJQT1R53WV2TJ1231WMUBDK1FVZH3OO"
    let applicationURL = "https://www.TheHangouts.com"
    
    override init() {
        super.init()
    }
    
    func fetchNearbyCafes(latitude: Double, longitude: Double, completionHandler: @escaping (Bool, Any) -> ())  {
        
        // Set up the URL request
        let endpointURL: String = "https://api.foursquare.com/v2/venues/search?v=20170210&ll=\(latitude),\(longitude)&query=coffee&intent=checkin&client_id=\(clientid)&client_secret=\(clientsecrete)"
        guard let url = NSURL(string: endpointURL) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSURLRequest(url: url as URL)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            // do stuff with response, data & error here
            print(error as Any)
            print(response as Any)
            if (error != nil) {
                print("Error");
                DispatchQueue.main.async(execute: { 
                    completionHandler(false, data!);
                })
            } else {
                do {
                    let parsedData =  try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    DispatchQueue.main.async(execute: {
                        completionHandler(true, parsedData)
                    })
                    print(parsedData )
                } catch let error as NSError {
                    print(error)
                }
            }
        })
        task.resume()
    }
}
