//
//  BusDetailsResultView.swift
//  SwiftyMe
//
//  Created by MacBook on 14/02/2023.
//

import SwiftUI

struct BusDetailsResultView: View {
    @State var item:ServicesSearchResultsModel
    
    var body: some View{
        ZStack{
            VStack{
                VStack{
                    HStack{
                        
                        Image(item.logo ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 70)
                            .padding([.top, .bottom], 5)
                            .padding([.trailing], 5)
                        
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
                                    .frame(width: 18, height: 18)
                                
                                Image(systemName: "headphones")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.bm_blue_icon)
                                    .frame(width: 18, height: 18)
                                
                                Image(systemName: "snowflake")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.bm_blue_icon)
                                    .frame(width: 18, height: 18)
                                
                                Image(systemName: "tv")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.bm_blue_icon)
                                    .frame(width: 18, height: 18)
                                
                                Spacer()
                                
                            }
                        }
                        
                        
                    }
                    .padding([.leading, .trailing], 15)
                    .padding([.bottom], 8)
                    .padding([.top], 8)
                    
                    Divider()
                    
                    HStack{
                        ///time
                        HStack(){
                            VStack(alignment:.leading){
                                Text(item.time ?? "")
                                    .foregroundColor(Color.bm_black_text)
                                    .font(.sfProRounded(.subheadline, weight: .bold))
                                Spacer()
                                Text(item.time ?? "")
                                    .foregroundColor(Color.bm_black_text)
                                    .font(.sfProRounded(.subheadline, weight: .bold))
                            }
                            .padding([.trailing], 10)
                            
                            VStack{
                                BorderedCircle(borderColor: Color.bm_black_text, radius: 7)
                                    .padding([.top], 3)
                                    
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 1)
                                    .padding([.top], -15)
                                    .offset(y:8)
                                
                                BorderedCircle(borderColor: Color.bm_black_text, radius: 7)
                                    .padding([.bottom], 3)
                            }
                        }.frame(width:120)
                       
                        /// locations from and to
                        HStack(){
                            VStack(alignment:.leading){
                                Text(item.fromLoction?.name ?? "")
                                    .foregroundColor(Color.bm_black_text)
                                    .font(.sfProRounded(15))
                                Text("Termina A32")
                                    .foregroundColor(Color.gray)
                                    .font(.sfProRounded(11))
                                
                                Spacer()
                                
                                HStack{
                                    Image(systemName: "clock")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(Color.bm_black_text)
                                    Text("06 Hours 15 Minutes")
                                        .foregroundColor(Color.bm_black_text)
                                        .font(.sfProRounded(12))
                                }
                                .padding(7)
                                .background(Color.bm_light_gray_black)
                                .cornerRadius(4.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4.0)
                                        .stroke(Color.gray, lineWidth: 1))
                                
                                Spacer()
                                
                                Text(item.toLocation?.name ?? "")
                                    .foregroundColor(Color.bm_black_text)
                                    .font(.sfProRounded(15))
                                Text("Termina B32")
                                    .foregroundColor(Color.gray)
                                    .font(.sfProRounded(11))
                                
                            }
                            .padding([.trailing], 15)
                            
                        }
                        
                        Spacer()
                        
                        /// locations icons
                        HStack(){
                            VStack(alignment:.leading){
                                
                                Image("location_on_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .padding(5)
                                    .foregroundColor(Color.white)
                                    .background(Color.bm_blue_icon)
                                    .cornerRadius(15)
                                
                                Spacer()
                                
                                Image("location_on_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .padding(5)
                                    .foregroundColor(Color.white)
                                    .background(Color.bm_blue_icon)
                                    .cornerRadius(15)
                                
                            }
                            .padding([.trailing], 10)
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height:120)
                    .padding([.leading, .trailing], 0)
                    .padding([.top, .bottom], 15)
                    
                    
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.bm_field_bg)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding([.leading,.trailing, .top], 10)
        }
        
    }
    
}

struct BusDetailsResultView_Previews: PreviewProvider {
    static var previews: some View {
        BusDetailsResultView(item: ServicesSearchResultsViewModelData.initServicesList().first!)
    }
}
