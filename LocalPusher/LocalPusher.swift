//
//  LocalPusher.h
//  LocalPusher.swift
//
//  Created by Sofiane Beors on 06/12/2016.
//  Copyright © 2016 Sofiane Beors. All rights reserved.
//


import UserNotifications

struct NotificationContent {
  public let content = UNMutableNotificationContent()
  
  init (title t: String, subtitle s: String? = nil, body b: String, attachements a: [UNNotificationAttachment]? = nil, repeats r: Bool) {
    let content = UNMutableNotificationContent()
    content.title = t
    content.body = b
    if s != nil { content.subtitle = s! }
    content.sound = LocalPusher.notificationSound ?? UNNotificationSound.default()
    if a != nil { content.attachments = a! }
  }
}


open class LocalPusher {
  static var isGrantedNotificationAccess = false
  open static var calendarId: Calendar.Identifier!
  static var notificationContent: NotificationContent!
  open static var notificationSound: UNNotificationSound?
  
  open class func requestAuthorisation(options o: UNAuthorizationOptions) {
    UNUserNotificationCenter.current().requestAuthorization(options: o) { (granted, errror) in
      self.isGrantedNotificationAccess = granted
    }
  }
    
  open class func setCalendarId(calendarId: Calendar.Identifier) {
    self.calendarId = calendarId
  }
  
  open class func scheduleNotification(at a: Date, title t: String, subtitle s: String? = nil, body b: String, repeats r: Bool, withAttachements attachements: [UNNotificationAttachment]? = nil) {
      if isGrantedNotificationAccess {
        let calendar = Calendar(identifier: calendarId)
        let components = calendar.dateComponents(in: .current, from: a)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        notificationContent = NotificationContent(title: t, subtitle: (s ?? nil), body: b, attachements: (attachements ?? nil), repeats: r)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        let request = UNNotificationRequest(
          identifier: "localPushScheduled",
          content: notificationContent.content,
          trigger: trigger
        )
    
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    } else {
      print("ERROR: Notifications acces is not granted !")
    }
  }
  
  open class func sendNotification(title t: String, subtitle s: String? = nil, body b: String, repeats r: Bool, withAttachements attachements: [UNNotificationAttachment]? = nil) {
    if isGrantedNotificationAccess {
      notificationContent = NotificationContent(title: t, subtitle: (s ?? nil), body: b, attachements: (attachements ?? nil), repeats: r)
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: r)
      let request = UNNotificationRequest(
        identifier: "localPush",
        content: notificationContent.content,
        trigger: trigger
      )
      
      UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
      UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    } else {
      print("ERROR: Notifications acces is not granted !")
    }
  }
}
