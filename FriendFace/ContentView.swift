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
                NavigationLink {
                    UserDetailsView(user: user)
                } label: {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.fill")
                            .foregroundStyle((user.isActive ? Color.green : Color.red), Color.blue)
                        Text(user.name)
                    }
                }
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
        
        guard users.isEmpty else {
            return
        }
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let decodedResponse = try decoder.decode([User].self, from: data)
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
