//
//  UserDetailsView.swift
//  FriendFace
//
//  Created by Zach Mommaerts on 10/30/23.
//

import SwiftUI

struct UserDetailsView: View {
    var user: User
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                Section {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "person.text.rectangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .foregroundStyle(Color.blue)
                        
                        Spacer()
                    }
                    
                    Text(user.about)
                        .padding()
                }
                
                Section {
                    Text("Age: \(user.age)")
                    Text("Company: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                    Text("Joined: \(user.registered.formatted(date: .long, time: .omitted))")
                    Text("Tags: \(user.tags.joined(separator: ", "))")
                } header: {
                    Text("Information")
                        .font(.headline.bold())
                }
                
                Section {
                    ForEach(user.friends, id: \.id) { friend in
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.blue)
                            Text(friend.name)
                        }
                    }
                } header: {
                    Text("Friends")
                        .font(.headline.bold())
                }
                .padding(.top)
            }
        }
        .padding()
        .navigationBarTitle(user.name, displayMode: .inline)
    }
    
}

#Preview {
    UserDetailsView(user: User())
}
