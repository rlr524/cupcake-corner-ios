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

struct PracticeViews: View {
    @State private var results = [Result]()
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
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
        
        VStack {
            AsyncImage(url: URL(string: "https://m.media-amazon.com/images/M/MV5BNmExZmE1ZGItMjdlOC00ZGM0LTlmMGUtMWVkMTE3YTg4Y2ZhXkEyXkFqcGdeQXVyMzk4NTg1MzI@._V1_.jpg"), scale: 7)
        }
        
        VStack {
            AsyncImage(url: URL(string: "https://m.media-amazon.com/images/M/MV5BNmExZmE1ZGItMjdlOC00ZGM0LTlmMGUtMWVkMTE3YTg4Y2ZhXkEyXkFqcGdeQXVyMzk4NTg1MzI@._V1_.jpg")) {image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                // Color.red // Temporary red box that goes away when image loads
                ProgressView() // Spinner while loading
            }
            .frame(width: 200, height: 200)
        }
        
        VStack {
            AsyncImage(url: URL(string: "https://m.media-amazon.com/images/M/MV5BNmExZmE1ZGItMjdlOC00ZGM0LTlmMGUtMWVkMTE3YTg4Y2ZhXkEyXkFqcGdeQXVyMzk4NTg1MzI@._V1_.jpg")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)
        }
        
        VStack {
            Form {
                Section {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                }
                
                Section {
                    Button("Create Account") {
                        print("Creating account...")
                    }
                }
                .disabled(disableForm)
            }
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
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
                print(results)
                print("results should have printed")
            }
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
    }
}

struct PracticeViews_Previews: PreviewProvider {
    static var previews: some View {
        PracticeViews()
    }
}
