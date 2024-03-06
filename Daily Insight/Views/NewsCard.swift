//
//  NewsCard.swift
//  Daily Insight
//
//  Created by Praval Gautam on 02/03/24.
//

import SwiftUI

struct NewsCard: View {
    var title : String
    var body: some View {
        ZStack{
            Color.color
            VStack{
                Text(title)
                    .lineLimit(2)
                    .font(.title3)
                    .foregroundStyle(.white)
                Spacer()
            }.padding(10)
            
        }.frame(width: 370,height: 120).cornerRadius(10)
        
    }
}

#Preview {
    NewsCard(title: "")
}
