//
//  ContentView.swift
//  FriendFace
//
//  Created by Zach Mommaerts on 10/28/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    private var users = [Friend]()
    
    var body: some View {
        NavigationView {
            List(cachedUsers, id: \.id) { user in
                NavigationLink {
                    UserDetailsView(user: user)
                } label: {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.fill")
                            .foregroundStyle((user.isActive ? Color.green : Color.red), Color.blue)
                        Text(user.wrappedName)
                    }
                }
            }
            .navigationTitle("Friend Face")
            .onAppear{
                Task {
                    await MainActor.run {
                        Task {
                            await loadData()
                        }
                    }
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
                    
                    Task {
                        await MainActor.run {
                            storeData(users: decodedResponse)
                        }
                    }
                } catch {
                    print("Could not decode data.")
                }
            }
        }.resume()
    }
    
    func storeData(users: [User]) {
        for user in users {
            let cachedUser = CachedUser(context: moc)
            
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = Int16(user.name) ?? 0
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.about = user.about
            cachedUser.registered = user.registered
            cachedUser.tags = user.tags.joined(separator: ",")
            
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                try? moc.save()
                cachedFriend.user = cachedUser
                cachedUser.addToFriends(cachedFriend)
            }
            
            print("\(user.name), User Count: \(user.friends.count)")
            print("\(cachedUser.wrappedName), CachedUser Count: \(cachedUser.wrappedFriends.count)")
            try? moc.save()
        }
    }
}

#Preview {
    ContentView()
}
