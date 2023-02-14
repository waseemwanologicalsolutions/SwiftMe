//
//  ResultsListRowView.swift
//  SwiftyMe
//
//  Created by MacBook on 13/02/2023.
//

import SwiftUI

struct ResultsListRowView: View {
    @State var item:ServicesSearchResultsModel
    
    var body: some View{
        ZStack{
            VStack{
                VStack{
                    HStack{
                        
                        Image(item.logo ?? "")
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                        VStack{
                            HStack{
                                Text(item.fromLoction?.shortCode ?? "")
                                    .foregroundColor(Color.bm_black_text)
                                    .font(.sfProRounded(.headline))
                            
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.bm_black_text)
                                    .frame(width: 30, height: 12)
                                
                                Text(item.toLocation?.shortCode ?? "")
                                    .foregroundColor(Color.bm_black_text)
                                    .font(.sfProRounded(.headline))
                                Spacer()
                                
                                Text(item.time ?? "")
                                    .foregroundColor(Color.bm_black_text)
                                    .font(.sfProRounded(.headline))
                            }
                            HStack(spacing:10){
                                Image(systemName: "wifi")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.bm_blue_icon)
                                    .frame(width: 20, height: 20)
                                
                                Image(systemName: "headphones")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.bm_blue_icon)
                                    .frame(width: 20, height: 20)
                                
                                Image(systemName: "snowflake")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.bm_blue_icon)
                                    .frame(width: 20, height: 20)
                                
                                Image(systemName: "tv")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.bm_blue_icon)
                                    .frame(width: 20, height: 20)
                                
                                Spacer()
                                
                            }
                        }
                        
                        
                    }
                    .padding([.leading, .trailing], 15)
                    .padding([.bottom], 8)
                    .padding([.top], 8)
                    
                    HStack{
                        Text("Price")
                            .foregroundColor(Color.bm_black_text)
                            .font(.sfProRounded(.headline))
                            .padding([.leading], 10)
                        Spacer()
                        Text(String(format:"Rs %0.1f",item.price ?? 0))
                            .foregroundColor(Color.bm_black_text)
                            .font(.sfProRounded(.headline))
                            .padding([.trailing], 10)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.bm_light_gray_black)
                    
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.bm_field_bg)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(10)
        }
        
    }
    
}

struct ResultsListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsListRowView(item: ServicesSearchResultsViewModelData.initServicesList().first!)
    }
}
