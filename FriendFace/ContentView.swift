//
//  ContentView.swift
//  FriendFace
//
//  Created by Zach Mommaerts on 10/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                Text(user.name)
            }
            .navigationTitle("Friend Face")
            .onAppear{
                Task {
                   await loadData()
                }
            }
        }
    }
    
    func loadData() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                    print(decodedResponse)
                    users = decodedResponse
                } catch {
                    print("Could not decode data.")
                }
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
