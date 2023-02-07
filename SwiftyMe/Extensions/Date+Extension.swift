//
//  Date+Extension.swift
//


import Foundation
extension Date{
    
    
    func getBargainListFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy - hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    func getBargainListShortYearFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yy - hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    func getBargainReqServerFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    func getRestDatailFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE. dd MMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    func getCustomFormatDateString(format:String) -> String{
        print(self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        let n = dateFormatter.string(from: self)
        print(n)
        return n
    }
    func getWalletExpiryFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE. dd MMM. yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    func getServerDateFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    func getServerTimeFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    func getChatTimeFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    func getChatMsgTimeFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US")
        let val = dateFormatter.string(from: self)
        //print("val=",val)
        return val
    }
    
    func getYear() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    func getMonth() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    func getOfferListFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    func getNotificationListFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    func getJustTimeFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    func getGroupDetailsFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    func getUTCDateTime() -> Double{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US")
        let timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormatter.timeZone = timeZone
        print(dateFormatter.string(from:self))
        let str = dateFormatter.string(from:self)
        let dt = dateFormatter.date(from: str)!.timeIntervalSince1970
        return dt
    }
    func getLocalFromUTCDateTime() -> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US")
        let timeZone = TimeZone.current
        dateFormatter.timeZone = timeZone
        print(dateFormatter.string(from:self))
        let str = dateFormatter.string(from:self)
        let dt = dateFormatter.date(from: str)!
        return dt
    }
    
    func addTimeDifference()->Date{
        let zoneCurrent = TimeZone.current
        let diff = zoneCurrent.secondsFromGMT()
        let localDate:Date! = self.addingTimeInterval(TimeInterval(diff))
        return localDate
    }
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)) ~= self
    }
    
    func getLastGroupMessageTime() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        let str = dateFormatter.string(from:self)
        let now = dateFormatter.string(from: Date())
        let dt = dateFormatter.date(from: str)!
        let nowDt = dateFormatter.date(from: now)!
        if dt.compare(nowDt) == .orderedSame{
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: self)
        }else{
            
            let yestDate = nowDt.addingTimeInterval(-86400)
            let weekDate = nowDt.addingTimeInterval(-86400*6)
            if yestDate.compare(dt) == .orderedSame{
                return "Yesterday"
            }else{
                let daysDiff = (Date().timeIntervalSince1970 - self.timeIntervalSince1970)/86400
                if daysDiff < 7{
                    return String(Int(daysDiff)) + " days ago"
                }else if dt.compare(weekDate) == .orderedDescending{
                    dateFormatter.dateFormat = "EEEE"
                    return dateFormatter.string(from: self)
                }else{
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    return dateFormatter.string(from: self)
                }
            }
            
        }
        
    }
    func years(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: sinceDate, to: self).year
    }
    
    func months(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: sinceDate, to: self).month
    }
    
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
    
    func hours(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: sinceDate, to: self).hour
    }
    
    func minutes(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: sinceDate, to: self).minute
    }
    
    func seconds(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: sinceDate, to: self).second
    }
}
