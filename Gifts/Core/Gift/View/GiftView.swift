//
//  GiftView.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import SwiftUI

struct GiftView: View {
    @State var searchText: String = ""
    
    @State var categories: [String] = ["Giftboxes", "For Her", "Popular"]
    @State var categoriesImage: [String] = ["categoriesItem1", "categoriesItem2", "products", "products1", "products2"]
    
    @State private var favorites: Set<Int> = []
    
    @State private var isFocused: Bool = false
    @FocusState private var isFocusedField: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        giftFlow
    }
}


extension GiftView {
    private var giftFlow: some View {
        VStack {
           
            HStack {
                Text(NSLocalizedString("giftTitle", comment: ""))
                    .font(.custom("SF Pro", size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.colorTextTitle)
                    .padding(.bottom)
                
                Spacer()
                
                searchField
            }
            
            addBanners
            
            products
            
            categoriesView

            Spacer()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background)
        .onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Text(NSLocalizedString("deliverTo", comment: ""))
                        .font(.custom("Open Sans", size: 18))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.theme.colorTextTitle)
                    Text("🇺🇸")
                    Text("USD")
                        .font(.custom("Open Sans", size: 18))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.theme.colorTextTitle)
                    Image("arrowDown")
                        .foregroundStyle(Color.theme.colorTextTitle)
                }
            }
        }
    }
    
    private var searchField: some View {
        HStack {
            if isFocused {
                HStack {
                    Image("search")
                        .foregroundStyle(Color.theme.secondaryColor)
                    
                    TextField("", text: $searchText, prompt: Text(NSLocalizedString("search", comment: ""))
                        .font(.custom("Open Sans", size: 17))
                        .foregroundStyle(Color.theme.secondaryColor))
                    .focused($isFocusedField)
                        .font(.custom("Open Sans", size: 17))
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.theme.colorWhite)
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .transition(.move(edge: .trailing).combined(with: .opacity))
                .animation(.easeInOut, value: isFocused)
                
                Button("Cancel") {
                    withAnimation {
                        isFocused = false
                        searchText = ""
                    }
                }
                .foregroundColor(Color.theme.secondaryColor)
                .transition(.move(edge: .trailing))
            } else {
                HStack {
                    Image("search")
                        .foregroundStyle(Color.theme.secondaryColor)
                    
                    Text(NSLocalizedString("search", comment: ""))
                        .font(.custom("Open Sans", size: 17))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.theme.secondaryColor)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.theme.colorWhite)
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .onTapGesture {
                    withAnimation {
                        isFocused = true
                        isFocusedField = true
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    
    private var addBanners: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(1...3, id: \.self) { index in
                    Image("banner")
                        .resizable()
                        .frame(width: 350, height: 150)
                        .cornerRadius(16)
//                        .padding(.horizontal, 5)
                }

            }
        }
        .scrollIndicators(.hidden)
        .frame(height: 160)
    }
    
    private var products: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(categoriesImage, id: \.self) { index in
                    VStack {
                        Image(index)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(12)
                        Text(NSLocalizedString("productInfo", comment: ""))
                            .font(.custom("Open Sans", size: 12))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.theme.colorTextTitle)
                            .frame(width: 80)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                    }
                }
                Text(NSLocalizedString("showAll", comment: ""))
                    .font(.custom("Open Sans", size: 14))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.colorTextTitle)
            }
        }
        .scrollIndicators(.hidden)
        .frame(height: 110)
    }
    
    private var categoriesView: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                Text(NSLocalizedString("allCategories", comment: ""))
                    .font(.custom("Open Sans", size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.colorTextTitle)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.theme.colorWhite)
                    )
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.theme.borderColor)
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.top)
                
                HStack {
                    ForEach(categories, id: \.self) { index in
                        HStack {
                            Text(index)
                                .font(.custom("Open Sans", size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(Color.theme.colorTextTitle)
                            Image("arrowDown")
                                .foregroundStyle(Color.theme.colorTextTitle)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.theme.background)
                        )
                    }
                }
                
                categoriesImages
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.theme.colorWhite)
            )
        }
        .scrollIndicators(.hidden)
    }
    
    private var categoriesImages: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Array(categoriesImage.enumerated()), id: \.offset) { index, item in
                    ZStack {
                        Image(item)
                            .resizable()
                            .frame(width: 156, height: 156)
                            .cornerRadius(12)
                        
                        Image("favorite")
                            .foregroundStyle(favorites.contains(index) ? Color.red.opacity(0.9) : Color.theme.colorBlack.opacity(0.5))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(8)
                            .padding(.trailing, 8)
                            .onTapGesture {
                                if favorites.contains(index) {
                                    favorites.remove(index)
                                } else {
                                    favorites.insert(index)
                                }
                            }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 0)
        }
        .scrollIndicators(.hidden)
    }
}
