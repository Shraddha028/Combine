//
//  ContentView.swift
//  CombineBootcamp
//
//  Created by Shraddha Sutar on 04/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ApiViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white,.purple, .white], startPoint: .topLeading, endPoint: .bottomLeading)
            VStack {
                List {
                    ForEach(vm.photos, id: \.id) { result in
                        VStack {
                            Text(result.title)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                .font(.body)
                            HStack {
                                AsyncImage(url: URL(string: result.url)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                Text(result.description)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.leading)
                        }
                        .listRowBackground(Color.purple)
                        .listRowSeparator(.hidden)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 0.5)
                        )
                    }
                }
            }
        }
        .ignoresSafeArea()
        .padding(.top, 50)
    }
}

#Preview {
    ContentView()
}
