//
//  ReelListHeaderView.swift
//  SwiftyMe
//
//  Created by MacBook on 31/03/2023.
//

import SwiftUI

struct ReelListHeaderView: View {
    
    var vm:ReelsDashboardSceneViewModel
    @State var days:Int = 0
    @State var hours:Int = 0
    @State var mintues:Int = 0
    @State var seconds:Int = 0
    @State var daysTitle:String = "Days"
    @State var hoursTitle:String = "Hours"
    @State var mintuesTitle:String = "Minutes"
    @State var secondsTitle:String = "Seconds"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            VStack() {
                ZStack() {
                    
                    HStack{
                        Image("rel_banner")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black)
                                    .opacity(0.60)
                            )
                            .frame(width: UIScreen.main.bounds.width - 30)
                        
                        
                    }
                    VStack{
                        Text("Digital Photography contest".uppercased())
                            .lineLimit(1)
                            .font(.sfProRounded(30, weight: .semibold))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(Color.white)
                            .padding([.bottom], 5)
                            .padding([.top], 40)
                            .shadow(color: .black, radius: 1)
                        Text("Capture life's beautiful moments and win Free 5 Days Hunza Trip")
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .font(.sfProRounded(16, weight: .semibold))
                            .foregroundColor(Color.white)
                            .shadow(color: .black, radius: 1)
                        
                        Spacer()
                        
                        HStack{
                            TimeTickView(value: $days, title: daysTitle)
                            TimeTickDotView()
                            TimeTickView(value: $hours, title: hoursTitle)
                            TimeTickDotView()
                            TimeTickView(value: $mintues, title: mintuesTitle)
                            TimeTickDotView()
                            TimeTickView(value: $seconds, title:  secondsTitle)
                        }
                        .onReceive(timer, perform: { _ in
                            //print("updating")
                            self.updateTime()
                        })
                        
                        .padding([.bottom], 40)
                        
                    }
                    .padding([.horizontal], 10)
                    
                }
                
            }
            .frame(height:280)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.reel_light_gray)
                    .opacity(0.3)
            ).shadow(radius: 4)
            
            HeaderViewInfo
            
        }
            
        .onAppear(){
            self.updateTime()
        }
        
        
    }
    
    var HeaderViewInfo: some View {
        
        VStack(){
            HStack(){
                Text("Don't forget to vote your photo daily after 24 hours. Contest voting will continue till April 20,2023")
                    .font(.sfProRounded(17, weight: .bold))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
            }
            .padding([.leading, .trailing], 1)
            .padding([.vertical], 5)
            .padding([.horizontal], 5)
    
        }
        .frame(maxWidth:.infinity)
        .background(Color.reel_blue)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
    
    func updateTime(){
        let date = "20-04-2023 23:59".getCustomDateFromString(format: "dd-MM-yyyy HH:mm")
        
        let distanceBetweenDates: TimeInterval? = date.timeIntervalSince(Date())
            let secondsInAnHour: Double = 3600
            let minsInAnHour: Double = 60
            let secondsInDays: Double = 86400
            
        days = Int((distanceBetweenDates! / secondsInDays))
        hours = Int((distanceBetweenDates! / secondsInAnHour)) - (days * 24)
        mintues = Int((distanceBetweenDates! / minsInAnHour)) - (days * 24 * 60) - (hours * 60)
        seconds = Int(distanceBetweenDates!) - (days * Int(secondsInDays)) - (hours * Int(secondsInAnHour)) - (mintues * 60)
        
        daysTitle = days > 1 ? "Days" : "Day"
        hoursTitle = hours > 1 ? "Hours" : "Hour"
        mintuesTitle = mintues > 1 ? "Minutes" : "Minute"
        secondsTitle = seconds > 1 ? "Seconds" : "Second"
        
    }
    
}

struct ReelListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReelListHeaderView(vm: ReelsDashboardSceneViewModel())
    }
}

struct TimeTickView: View {
    @Binding var value:Int
    @State var title:String = "Days"
    var body: some View {
        VStack(spacing: 5){
            Text("\(value)")
                .lineLimit(1)
                .font(.sfProRounded(30, weight: .semibold))
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.white)
                .shadow(color: .black, radius: 1)
            
            Text(title.uppercased())
                .lineLimit(1)
                .font(.sfProRounded(16, weight: .semibold))
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.white)
                .shadow(color: .black, radius: 1)
        }
    }
}

struct TimeTickDotView: View {
    var body: some View {
        VStack(spacing: 5){
            Text(":")
                .lineLimit(1)
                .font(.sfProRounded(30, weight: .semibold))
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.white)
                .shadow(color: .black, radius: 1)
            
        }
    }
}
