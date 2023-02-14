//
//  BusFacilitiesView.swift
//  SwiftyMe
//
//  Created by MacBook on 14/02/2023.
//

import SwiftUI

struct BusFacilitiesView: View {
    @State var item:ServicesSearchResultsModel
    
    var body: some View{
        ZStack{
            VStack{
                VStack{
                    HStack(){
                        Text("How's my bus")
                            .foregroundColor(Color.bm_black_text)
                            .font(.sfProRounded(.headline, weight: .bold))
                            .padding([.top, .leading, .trailing], 15)
                        Spacer()
                    }
                    HStack(){
                        Text("Bus details for my journey")
                            .foregroundColor(Color.bm_black_text)
                            .font(.sfProRounded(11))
                            .padding([.leading, .trailing, .bottom], 15)
                        Spacer()
                    }
                    
                    VStack(alignment:.leading){
                        FlexibleView(
                            availableWidth: (UIScreen.main.bounds.width - 10), data: item.facilities,
                            spacing: 10,
                            alignment: .leading
                        ) { item in
                            GridIemFacility(icon: item.icon ?? "tv", title: item.name ?? "")
                        }
                    }
                    .padding([.bottom, .leading, .trailing], 15)
                    .frame(maxWidth: .infinity)
                    
                    
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.bm_field_bg)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding([.leading, .trailing], 10)
        }
    }
}

struct BusFacilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        BusFacilitiesView(item: ServicesSearchResultsViewModelData.initServicesList()[0])
    }
}

struct GridIemFacility:View{
    @State var icon:String = "tv"
    @State var title:String = "Tablet"
    var body : some View {
        HStack{
            HStack(){
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.bm_blue_icon)
                    .frame(width: 20, height: 20)
                Text(title)
                    .foregroundColor(Color.bm_black_text)
                    .font(.sfProRounded(14, weight: .medium))
                
            }
            .padding([.leading, .trailing], 10)
        }
        .padding([.top, .bottom], 5)
        .background(Color.bm_light_gray_black)
        .cornerRadius(5)
    }
}
