//
//  ViewModel.swift
//  URLSession_Decodable
//
//  Created by Iván Clemente Moreno on 1/2/23.
//

import Foundation

struct UserModel: Decodable { //Comand + click para generar código "Explicit codable implementation"
    let iduser: String
    let email: String
    let password: String
    let name: String
    let surname: String
    
    enum CodingKeys: String, CodingKey {
        case iduser
        case email
        case password
        case name
        case surname
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<UserModel.CodingKeys> = try decoder.container(keyedBy: UserModel.CodingKeys.self)
        
        self.iduser = try container.decode(String.self, forKey: UserModel.CodingKeys.iduser)
        self.email = try container.decode(String.self, forKey: UserModel.CodingKeys.email)
        self.password = try container.decode(String.self, forKey: UserModel.CodingKeys.password)
        self.name = try container.decode(String.self, forKey: UserModel.CodingKeys.name)
        self.surname = try container.decode(String.self, forKey: UserModel.CodingKeys.surname)
        
    }
    
    
    
}
struct UserBasicInfo{
    let iduser: String
    let email: String
    let password: String
    let name: String
    let surname: String
    
    static var empty: Self {
        .init(iduser: "", email: "", password: "", name: "", surname: "")
    }
    
}



final class ViewModel: ObservableObject {
    @Published var userBasicInfo: UserBasicInfo = .empty
    
    func executeRequest() async {
        let userURL = URL(string: "http://trimbotest.ddns.net/simple_API_RESTful/post.php?iduser=3")!
        //======================================ASYNC/AWAIT============================
        let (data, _) = try! await URLSession.shared.data(from: userURL)
        let userModel = try! JSONDecoder().decode(UserModel.self, from: data)
        print("User Model \(userModel)")
        
        DispatchQueue.main.async {
            self.userBasicInfo = .init(iduser: userModel.iduser, email: userModel.email, password: userModel.password, name: userModel.name, surname: userModel.surname)
        }
        
        //=============================================================================
        
        
        //======================================CALLBACK================================
        /**URLSession.shared.dataTask(with: userURL) { data, response, error in
            let userModel = try! JSONDecoder().decode(UserModel.self, from: data!) //deberiamos evitar force (!)
            print("======================================")
            print(userModel)
            print("======================================")
            DispatchQueue.main.async {
                self.userBasicInfo = .init(iduser: userModel.iduser, email: userModel.email, password: userModel.password, name: userModel.name, surname: userModel.surname)
            }
        }.resume() //MUY IMPORTANTE NO OLVIDAR EL RESUME**/
        //==============================================================================
    }
    
    
    func executeAPI() {
        let urlSession = URLSession.shared
        let url = URL(string: "http://trimbotest.ddns.net/simple_API_RESTfull/post.php") //API pública que he elegido para hacer pruebas

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
