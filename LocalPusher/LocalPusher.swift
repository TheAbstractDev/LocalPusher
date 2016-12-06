//
//  LocalPusher.h
//  LocalPusher.swift
//
//  Created by Sofiane Beors on 06/12/2016.
//  Copyright © 2016 Sofiane Beors. All rights reserved.
//


import Foundation
import UIKit
import UserNotifications

open class LocalPusher {
  static var isGrantedNotificationAccess = false
  static var notificationContent = NotificationContent()
  open static var calendarId: Calendar.Identifier!
  
  open class func requestAuthorisation(options o: UNAuthorizationOptions) {
    UNUserNotificationCenter.current().requestAuthorization(options: o) { (granted, errror) in
      self.isGrantedNotificationAccess = granted
    }
  }
  
  open class func scheduleNotification(at a: Date, title t: String, subtitle s: String? = nil, body b: String, repeats r: Bool) {
      if isGrantedNotificationAccess {
        let calendar = Calendar(identifier: calendarId)
        let components = calendar.dateComponents(in: .current, from: a)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        if s != nil {
          notificationContent = NotificationContent(title: t, subtitle: s, body: b, repeats: r)
        } else {
          notificationContent = NotificationContent(title: t, body: b, repeats: r)
        }
    
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
  
  open class func sendNotification(title t: String, subtitle s: String? = nil, body b: String, repeats r: Bool) {
    if isGrantedNotificationAccess {
      if s != nil {
        notificationContent = NotificationContent(title: t, subtitle: s, body: b, repeats: r)
      } else {
        notificationContent = NotificationContent(title: t, body: b, repeats: r)
      }
      
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
