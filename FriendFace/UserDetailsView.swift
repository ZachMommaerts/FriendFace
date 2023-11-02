//
//  UserDetailsView.swift
//  FriendFace
//
//  Created by Zach Mommaerts on 10/30/23.
//

import SwiftUI

struct UserDetailsView: View {
    var user: CachedUser
    
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
                    
                    Text(user.wrappedAbout)
                        .padding()
                }
                
                Section {
                    Text("Age: \(user.age)")
                    Text("Company: \(user.wrappedCompany)")
                    Text("Email: \(user.wrappedEmail)")
                    Text("Address: \(user.wrappedAddress)")
                    Text("Joined: \(user.wrappedRegistered.formatted(date: .long, time: .omitted))")
                    ForEach(user.wrappedTags.split(separator: ","), id: \.self) { tag in
                        Text(tag)
                            .foregroundStyle(.white)
                            .background(.blue)
                    }
                } header: {
                    Text("Information")
                        .font(.headline.bold())
                }
                
                Section {
                    Text(String(user.wrappedFriends.count))
                    ForEach(user.wrappedFriends, id: \.id) { friend in
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.blue)
                            Text(friend.wrappedName)
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
        .navigationBarTitle(user.wrappedName, displayMode: .inline)
    }
    
}

#Preview {
    UserDetailsView(user: CachedUser())
}
