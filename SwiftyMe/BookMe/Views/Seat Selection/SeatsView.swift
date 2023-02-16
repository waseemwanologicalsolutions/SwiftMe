//
//  SeatsView.swift
//  SwiftyMe
//
//  Created by MacBook on 15/02/2023.
//

import SwiftUI

struct SeatsView: View {
    
    @Binding var seats:[SeatModel]
    @Binding var seatsSelected:[SeatModel]
    @Binding var showGenderTypeSelection:Bool
    @Binding var seatCurrentSelection:SeatModel?
    
    let coloumns = [
        GridItem(.flexible()),
        GridItem(.flexible(), spacing: 50),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack{
            VStack{
                
                SeatsColorsView
                
                Divider()
                    .padding([.bottom], 10)
                
                VStack() {
                    HStack{
                        Spacer()
                        Image("steering-wheel")
                            .resizable()
                            .frame(width:40, height:40)
                            .foregroundColor(Color.bm_black_text)
                            .padding([.trailing], 30)
                    }.frame(height: 60)
                    
                    LazyVGrid(columns: coloumns, spacing: 10) {
                        ForEach(seats, id: \.self) { item in
                            
                            SeatsLayoutView(seat: item, seatsSelected: $seatsSelected, showGenderTypeSelection: $showGenderTypeSelection, seatCurrentSelection:$seatCurrentSelection)
                            
                        }
                    }
                    HStack{
                        Color.clear
                    }.frame(height: 15)
                   
                }
                .background(Color.bm_seats_bg)
                .cornerRadius(10)
                .padding([.leading, .trailing], 10)
                
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, alignment: .center, spacing: 10) {
                        ForEach(seatsSelected, id: \.self) { item in
                            
                            ZStack{
                                Rectangle()
                                    .fill((item.gender ?? "") == "Male" ? Color.bm_dark_blue : Color.bm_pink)
                                    .cornerRadius(6)
                                HStack{
                                    Text(item.name ?? "")
                                        .font(.sfProRounded(20, weight: .semibold))
                                        .foregroundColor(Color.white)
                                        .padding([.leading], 15)
                                    Spacer()
                                    TextFieldClearButton(color:Color.white, action:{
                                        if let index = self.seatsSelected.firstIndex(where: {$0.name == item.name}){
                                            self.seatsSelected.remove(at: index)
                                        }
                                        if let index = self.seats.firstIndex(where: {$0.name == item.name}){
                                            self.seats[index].isSelected = false
                                            self.seats[index].id = UUID().uuidString
                                        }
                                    })
                                    .padding([.trailing], 10)
                                    
                                    
                                }
                                
                            }
                            .frame(width: 85)
                            .frame(height: 50)
                            
                        }
                    }
                }
                .frame(height: 50)
                .padding([.leading, .trailing], 15)
                .padding([.bottom], 5)
    
            }
            
            .padding([.top], 10)
            .background(Color.bm_field_bg)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding([.leading, .trailing], 10)
            
        }
        
    }
    
    var SeatsColorsView:some View{
        
        HStack{
            HStack(spacing:30){
                
                VStack{
                    Rectangle()
                        .fill(Color.bm_seats_bg)
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.bm_blue_icon, lineWidth: 1)
                        )
                    Text("Available")
                        .font(.sfProRounded(12))
                }.frame(width: 60, height: 40)
                
                VStack{
                    Rectangle()
                        .fill(Color.bm_orange)
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.bm_orange, lineWidth: 1)
                        )
                    Text("Selected")
                        .font(.sfProRounded(12))
                }.frame(width: 60, height: 40)
                
            }
            
            Spacer()
            Divider().padding([.top, .bottom], 15)
            Spacer()
            
            HStack(spacing:30){
                
                VStack{
                    Rectangle()
                        .fill(Color.bm_dark_blue)
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.bm_dark_blue, lineWidth: 1)
                        )
                    Text("Male")
                        .font(.sfProRounded(12))
                }.frame(width: 60, height: 40)
                
                VStack{
                    Rectangle()
                        .fill(Color.bm_pink)
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(Color.bm_pink, lineWidth: 1)
                        )
                    Text("Female")
                        .font(.sfProRounded(12))
                }.frame(width: 60, height: 40)
                
            }
        }
        .frame(height: 80)
        .padding([.leading, .trailing], 10)
    }
}

struct SeatsView_Previews: PreviewProvider {
    static var previews: some View {
        SeatsView(seats: .constant(SeatSelectionViewModelData.initData()), seatsSelected: .constant([]), showGenderTypeSelection: .constant(false), seatCurrentSelection:.constant(nil))
    }
}


struct SeatsLayoutView: View {
    
    @State var seat:SeatModel?
    @Binding var seatsSelected:[SeatModel]
    @Binding var showGenderTypeSelection:Bool
    @Binding var seatCurrentSelection:SeatModel?
    
    var body: some View {
        Button(action:{
            if seat?.isReserved == false{
                if let index = self.seatsSelected.firstIndex(where: {$0.name == seat?.name}){
                    self.seatsSelected.remove(at: index)
                    seat!.isSelected = false
                }else{
                    seatCurrentSelection = seat
                    showGenderTypeSelection = true
                }
            }
        }){
            Text(seat?.name ?? "")
                .background(
                    Rectangle()
                        .fill(seatColor(seat!))
                        .frame(width: 45, height: 45)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(seatBorderColor(seat!), lineWidth: 1)
                        ))
        }
        .frame(width: 45, height: 45)
    }
    
    var seatColor = { (item:SeatModel) ->Color in
        if item.isReserved == true{
            if item.gender == "Male"{
                return Color.bm_dark_blue
            }else{
                return Color.bm_pink
            }
        }else if item.isSelected == true{
            return Color.bm_orange
        }
      return Color.bm_seats_bg
    }
    var seatBorderColor = { (item:SeatModel) ->Color in
        if item.isReserved == true{
            if item.gender == "Male"{
                return Color.bm_dark_blue
            }else{
                return Color.bm_pink
            }
        }else if item.isSelected == true{
            return Color.bm_orange
        }
      return Color.bm_blue_icon
    }
}

struct SeatsLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        SeatsLayoutView(seat: SeatSelectionViewModelData.initData()[0], seatsSelected: .constant([]), showGenderTypeSelection: .constant(false), seatCurrentSelection: .constant(nil))
    }
}
