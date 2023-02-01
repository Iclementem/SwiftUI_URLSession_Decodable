//
//  ViewModel.swift
//  URLSession_Decodable
//
//  Created by Iván Clemente Moreno on 1/2/23.
//

import Foundation

final class ViewModel {
    func executeAPI() {
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.preciodelaluz.org//v1/prices/all?zone=PCB") //API pública que he elegido para hacer pruebas

        urlSession.dataTask(with: url!) { data, response, error in
            print("================HEADER===============")
            print(String(describing: data))
            print("===============RESPONSE===============")
            print(String(describing: response))
            print("================ERROR=================")
            print(String(describing: error))
            
            
            if let data = data { //En caso de que nos llegue data
                let json = try? JSONSerialization.jsonObject(with: data)
                print(String(describing: json))
            }
            
            
            
            
        }.resume()
    }
}
