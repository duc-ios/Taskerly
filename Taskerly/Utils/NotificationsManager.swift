//
//  NotificationsManager.swift
//  Taskerly
//
//  Created by Duc on 11/8/24.
//

import NotificationCenter

class NotificationsManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationsManager()

    func setup() {
        let center = UNUserNotificationCenter.current()
        center.delegate = NotificationsManager.shared
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error {
                logger.debug("Notification Permission error \(error)")
            } else if success {
                logger.debug("Notification Permission granted")
            } else {
                logger.debug("Notification Permission denied")
            }
        }
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        logger.debug("Notification willPresent \(notification.request.content.userInfo)")
        completionHandler(.banner)
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        logger.debug("Notification didReceive \(response.notification.request.content.userInfo)")
        completionHandler()
    }
}
