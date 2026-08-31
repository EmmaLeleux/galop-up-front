//
//  OnePostView.swift
//  Galop'Up
//
//  Created by Emma on 31/08/2026.
//

import SwiftUI

struct OnePostView: View {
    var post: Post
    var body: some View {
        VStack{
            HStack{
                
            }
        }
    }
}

#Preview {
    OnePostView(post: Post(id: UUID(), title: "test", content: "test", pictures: [], author: User(id: UUID(), username: "user", email: "user@test.com", age: 3, googleId: nil, appleId: nil, level: LevelGalopUserEnum.GALOP3, picture: nil, role: UserRoleEnum.USER, isBanned: false, deletedAt: nil), nblikes: 3, createdAt: Date()))
}
