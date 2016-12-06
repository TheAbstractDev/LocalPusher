//
//  NotificationContent.swift
//  LocalPusher
//
//  Created by Sofiane Beors on 06/12/2016.
//  Copyright © 2016 Sofiane Beors. All rights reserved.
//

import UserNotifications

struct NotificationContent {
  public let content = UNMutableNotificationContent()
  init () {}
  
  init (title t: String, subtitle s: String? = nil, body b: String, repeats r: Bool) {
    let content = UNMutableNotificationContent()
    content.title = t
    content.body = b
    if s != nil { content.subtitle = s! }
    content.sound = UNNotificationSound.default()
  }
}
