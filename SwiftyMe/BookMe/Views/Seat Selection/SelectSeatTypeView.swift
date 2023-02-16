//
//  SelectSeatTypeView.swift
//  SwiftyMe
//
//  Created by MacBook on 16/02/2023.
//

import SwiftUI

struct SelectSeatTypeView: View {
    
    @State var seat:SeatModel? = SeatSelectionViewModelData.initData()[0]
    let maleAction: () -> Void
    let femaleAction: () -> Void
    
    var body: some View {
        VStack{
            HStack{
                Text("Select seat type")
                    .font(.sfProRounded(.title2))
                
                Text("Seat no: " + (seat?.name ?? ""))
                    .font(.sfProRounded(12))
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 5.0)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Spacer()
                
            }
            .padding([.leading, .trailing, .top], 15)
            .padding([.bottom], 15)
            
            VStack{
                HStack(spacing:20){
                    
                    HStack{
                        Rectangle()
                            .fill(Color.bm_dark_blue)
                            .frame(width: 40, height: 40)
                            .cornerRadius(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(Color.bm_dark_blue, lineWidth: 1)
                            )
                        Text("Male")
                            .font(.sfProRounded(17))
                    }
                    .frame(maxWidth:.infinity)
                    .frame(height: 70)
                    .background(Color.bm_light_gray_black)
                    .cornerRadius(6.0)
                    .onTapGesture {
                        self.maleAction()
                    }
                    
                        
                    HStack{
                        Rectangle()
                            .fill(Color.bm_pink)
                            .frame(width: 40, height: 40)
                            .cornerRadius(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(Color.bm_pink, lineWidth: 1)
                            )
                        Text("Female")
                            .font(.sfProRounded(17))
                    }
                    .frame(maxWidth:.infinity)
                    .frame(height: 70)
                    .background(Color.bm_light_gray_black)
                    .cornerRadius(6.0)
                    .onTapGesture {
                        self.femaleAction()
                    }
                    
                }
                
            }
            .padding([.leading, .trailing], 15)
            .frame(maxWidth:.infinity)
            
        }.padding([.top, .bottom], 20)
    }
}

struct SelectSeatTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSeatTypeView(maleAction: {}, femaleAction: {})
    }
}
