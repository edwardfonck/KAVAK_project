//
//  Services.swift
//  kavak_project
//
//  Created by Eduardo Fonseca on 8/5/19.
//  Copyright © 2019 Eduardo Fonseca. All rights reserved.
//

import UIKit

//Constants
let urlBrastlewark = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
class Services: NSObject {
    
    public class func callServiceBrastlewarkon(Success: @escaping([Gnome]) -> Void, onError: @escaping(NSError) -> Void){
        
        guard let endPoint = URL(string: urlBrastlewark) else { return }
        
        let session = URLSession.shared
        
        //        session.dataTask(with: endPoint)
        
        let dataTask = session.dataTask(with: endPoint) { (data, response, error) in
            guard let data = data else { return }
            
            if let jsonObject = try? JSONDecoder().decode(RootNode_Brastlewarkon.self, from: data)
            {
                if jsonObject.Brastlewark.count > 0
                {
                   Success(jsonObject.Brastlewark)
                }
                else
                {
                    onError(error! as NSError)
                }
            }
            
        }
        
        dataTask.resume()
        
    }
    
}
