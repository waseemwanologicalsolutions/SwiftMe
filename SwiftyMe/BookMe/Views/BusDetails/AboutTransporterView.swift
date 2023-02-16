//
//  AboutTransporterView.swift
//  SwiftyMe
//
//  Created by MacBook on 14/02/2023.
//

import SwiftUI

struct AboutTransporterView: View {
    var body: some View {
        
        ZStack{
            VStack{
                VStack{
                    HStack(){
                        Text("About the bus transporter")
                            .foregroundColor(Color.bm_black_text)
                            .font(.sfProRounded(.headline, weight: .bold))
                            .padding([.top, .leading, .trailing], 15)
                        Spacer()
                    }
                    HStack(){
                        Text("Some details about bus transporter and public feedback")
                            .foregroundColor(Color.bm_black_text)
                            .font(.sfProRounded(11))
                            .padding([.leading, .trailing], 15)
                        Spacer()
                    }
                    HStack(){
                        Text("To be noticed")
                            .foregroundColor(Color.bm_black_text)
                            .font(.sfProRounded(12, weight: .medium))
                            .padding([.leading], 15)
                        Text("last 10 days")
                            .foregroundColor(Color.bm_blue_icon)
                            .font(.sfProRounded(10, weight: .medium))
                            .padding([.leading], 0)
                        Spacer()
                    }
                    .padding([.top], 1)
                    .padding([.bottom], 5)
                    HStack(spacing:5){
                        GridIemAbout(icon: "clock.badge.exclamationmark", title: "Late Deparature", value: "0%")
                        GridIemAbout(icon: "person.fill.questionmark", title: "Staff", value: "Good")
                        GridIemAbout(icon: "hand.thumbsup", title: "Recommendation", value: "100%")
                    }
                    .padding([.bottom, .leading, .trailing], 15)
                    .frame(height: 60)
                   
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

struct AboutTransporterView_Previews: PreviewProvider {
    static var previews: some View {
        AboutTransporterView()
    }
}

struct GridIemAbout:View{
    @State var icon:String = "tv"
    @State var title:String = "Tablet"
    @State var value:String = "0%"
    var body : some View {
        VStack{
            HStack{
                Text(title)
                    .foregroundColor(Color.bm_black_text)
                    .font(.sfProRounded(11, weight: .regular))
                    .padding([.leading], 10)
                Spacer()
            }
            HStack(){
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.bm_blue_icon)
                    .frame(width: 16, height: 16)
                Text(value)
                    .foregroundColor(Color.bm_black_text)
                    .font(.sfProRounded(14, weight: .medium))
                Spacer()
                
            }
            .padding([.leading, .trailing], 10)
        }
        .padding([.top, .bottom], 5)
        .background(Color.bm_light_gray_black)
        .cornerRadius(5)
    }
}
