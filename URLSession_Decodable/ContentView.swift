//
//  ContentView.swift
//  URLSession_Decodable
//
//  Created by Iván Clemente Moreno on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    //private var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            /**Button("Crear petición HTTP") {
                viewModel.executeAPI()
            }**/
            Text("ID: \(viewModel.userBasicInfo.iduser)")
            Text("Email: \(viewModel.userBasicInfo.email)")
            Text("Contraseña: \(viewModel.userBasicInfo.password)")
            Text("Nombre: \(viewModel.userBasicInfo.name)")
            Text("Apellido: \(viewModel.userBasicInfo.surname)")
        }
        .onAppear{
            Task{
                await viewModel.executeRequest()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
