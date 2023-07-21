//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Rob Ranf on 7/19/23.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackID: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackID) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
            print("task ran")
        }
    }
    
    func loadData() async {
        guard let url = URL(
            string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("url session running")
            print(data)
            
            let decoder = JSONDecoder()
            
            if let decodedResponse = try? decoder.decode(Response.self, from: data) {
                print("Running before results...")
                results = decodedResponse.results
                print(results)
                print("Running")
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
