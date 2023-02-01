//
//  ContentView.swift
//  URLSession_Decodable
//
//  Created by Iván Clemente Moreno on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    
    private var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            Button("Crear petición HTTP") {
                viewModel.executeAPI()
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
