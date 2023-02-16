//
//  SeatSelectionView.swift
//  SwiftyMe
//
//  Created by MacBook on 15/02/2023.
//

import SwiftUI

struct SeatSelectionView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var searchRouteViewModel:SearchRouteViewModel
    @StateObject var vm = SeatSelectionViewModel()
    @State var result:ServicesSearchResultsModel = ServicesSearchResultsViewModelData.initServicesList()[0]
    @State var enableConfirmBtn:Bool = false

    
    var body: some View {
        ZStack(alignment:.bottom){
            VStack(){
                
                HeaderView
                
                ScrollView(.vertical){
                    VStack(){
                        HStack{
                            Text(fromToTitle)
                                .foregroundColor(Color.bm_black_text)
                                .font(.sfProRounded(12))
                            Spacer()
                        }
                        .padding([.leading, .trailing], 15)
                        
                        SeatsView(seats: $vm.seats, seatsSelected: $vm.seatsSelected, showGenderTypeSelection: $vm.showGenderTypeSelection, seatCurrentSelection: $vm.seatCurrentSelection)
                    }
                    .padding([.bottom], 10)
                }
                
                VStack{
                    HStack{
                        Text("Tap on available seat to select it. You can select maximum 4 seats.")
                            .foregroundColor(Color.bm_black_text)
                            .font(.sfProRounded(12))
                            .opacity(0.85)
                       
                    }
                    .padding([.leading, .trailing], 15)
                    .padding([.top], 5)
                    
                    ConfirmButton.onTapGesture {
                        print("confirm tapped")
                    }
                }
                
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden()
        .onChange(of: vm.seatsSelected) { newValue in
            if vm.seatsSelected.count > 0{
                enableConfirmBtn = true
            }else{
                enableConfirmBtn = false
            }
        }
        .sheet(isPresented: $vm.showGenderTypeSelection){
            SelectSeatTypeView(seat:vm.seatCurrentSelection, maleAction: {
                vm.seatCurrentSelection?.gender = "Male"
                vm.seatsSelected.append(vm.seatCurrentSelection!)
                vm.seatCurrentSelection?.isSelected = true
                vm.seatCurrentSelection?.id = UUID().uuidString
                vm.showGenderTypeSelection = false
                if let index = vm.seats.firstIndex(where: {$0.name == vm.seatCurrentSelection?.name}){
                    vm.seats[index] = vm.seatCurrentSelection!
                }
                
            }, femaleAction: {
                vm.seatCurrentSelection?.gender = "Female"
                vm.seatsSelected.append(vm.seatCurrentSelection!)
                vm.seatCurrentSelection?.isSelected = true
                vm.seatCurrentSelection?.id = UUID().uuidString
                vm.showGenderTypeSelection = false
                if let index = vm.seats.firstIndex(where: {$0.name == vm.seatCurrentSelection?.name}){
                    vm.seats[index] = vm.seatCurrentSelection!
                }
            })
            .presentationDetents([.height(200)])
            .transition(.move(edge: .bottom))
        }
        .onAppear{
            vm.seats = SeatSelectionViewModelData.initData()
            //vm.seatsSelected = SeatSelectionViewModelData.initData()
        }
    }
    
    var ConfirmButton:some View{
        HStack{
            Text("Confirm")
                .foregroundColor(Color.white)
                .font(.sfProRounded(.headline))
                .padding([.leading], 15)
        }
        .frame(maxWidth: .infinity)
        .frame(height:50)
        .background(Color.bm_blue_bg)
        .cornerRadius(15)
        .opacity(enableConfirmBtn ? 1 : 0.5)
        .padding([.leading, .trailing, .bottom], 15)
        .padding([.top], 0)
    }
    
    var fromToTitle:String{
        var sbbSt = [String]()
        sbbSt.append("Select your seat from ")
        sbbSt.append((searchRouteViewModel.selectedLocationFrom?.name ?? ""))
        sbbSt.append(" to ")
        sbbSt.append((searchRouteViewModel.selectedLocationTo?.name ?? ""))
        return sbbSt.joined()
    }
    
    var HeaderView: some View {
        
        VStack(spacing: 10){
            HStack(alignment: .center){
                
                Button(action:{
                    self.mode.wrappedValue.dismiss()
                }){
                    HStack{
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 26, height: 26)
                        
                        Text("Seat Selection")
                            .foregroundColor(Color.white)
                            .font(.sfProRounded(.headline))
                            .padding([.leading], 0)
                            .padding([.trailing], 0)
                        
                        Spacer()
                    }
                }
                .frame(height: 40)
                
            }
            .padding([.leading, .trailing], 10)
            
            ///subtitle
            HStack{
                VStack(alignment:.leading, spacing: 2){
                    Text("Outbound")
                        .foregroundColor(Color.white)
                        .font(.sfProRounded(12))
                    Text(searchRouteViewModel.selectedDate.getCustomFormatDateString(format: "dd MMM"))
                        .foregroundColor(Color.white)
                        .font(.sfProRounded(12))
                        
                }
                
                Spacer()
                HStack{
                    Text(searchRouteViewModel.selectedLocationFrom?.shortCode ?? "From")
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                        .font(.sfProRounded(12))
                    BorderedCircle(borderColor: Color.white, radius: 5, strokeWidth: 2)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 50, height: 2)
                        .cornerRadius(1)
                        .padding([.leading], -15)
                        .offset(x:8)
                    BorderedCircle(borderColor: Color.white, radius: 5, strokeWidth: 2)
                    Text(searchRouteViewModel.selectedLocationTo?.shortCode ?? "To ")
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                        .font(.sfProRounded(12))
                        
                }
                Spacer()
            }
            .padding([.leading, .trailing], 15)
            .padding([.bottom], 15)

            
        }
        .background(Color.bm_blue_bg)
    }
}

struct SeatSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SeatSelectionView().environmentObject(SearchRouteViewModel())
    }
}
