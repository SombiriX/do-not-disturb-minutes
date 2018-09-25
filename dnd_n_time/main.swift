//
//  main.swift
//  dnd_n_time
//
//  Based on code from this SO answer https://stackoverflow.com/a/45645595/6054814
//  I just added an ability to set dnd for some number of minutes
//  Defaults to 30 minutes
//
//  Created by Sombiri Enwemeka on 9/25/18.
//

import Foundation

func enableDND(start: Float, stop: Float){

    CFPreferencesSetValue(
        "dndStart" as CFString,
        CGFloat(start) as CFPropertyList,
        "com.apple.notificationcenterui" as CFString,
        kCFPreferencesCurrentUser,
        kCFPreferencesCurrentHost
    )

    CFPreferencesSetValue(
        "dndEnd" as CFString,
        CGFloat(stop) as CFPropertyList,
        "com.apple.notificationcenterui" as CFString,
        kCFPreferencesCurrentUser,
        kCFPreferencesCurrentHost
    )

    CFPreferencesSetValue(
        "doNotDisturb" as CFString,
        true as CFPropertyList,
        "com.apple.notificationcenterui" as CFString,
        kCFPreferencesCurrentUser,
        kCFPreferencesCurrentHost
    )

    commitDNDChanges()
}

func disableDND(){
    CFPreferencesSetValue(
        "dndStart" as CFString,
        nil,
        "com.apple.notificationcenterui" as CFString,
        kCFPreferencesCurrentUser,
        kCFPreferencesCurrentHost
    )

    CFPreferencesSetValue(
        "dndEnd" as CFString,
        nil,
        "com.apple.notificationcenterui" as CFString,
        kCFPreferencesCurrentUser,
        kCFPreferencesCurrentHost
    )

    CFPreferencesSetValue(
        "doNotDisturb" as CFString,
        false as CFPropertyList,
        "com.apple.notificationcenterui" as CFString,
        kCFPreferencesCurrentUser,
        kCFPreferencesCurrentHost
    )

    commitDNDChanges()
}

func commitDNDChanges(){
    CFPreferencesSynchronize(
        "com.apple.notificationcenterui" as CFString,
        kCFPreferencesCurrentUser,
        kCFPreferencesCurrentHost
    )

    DistributedNotificationCenter.default().postNotificationName(
        NSNotification.Name(
            rawValue: "com.apple.notificationcenterui.dndprefs_changed"
        ),
        object: nil,
        userInfo: nil,
        deliverImmediately: true
    )
}

func minutesSinceMidnight() -> Int
{
    let now = Date()
    let calendar = Calendar.current
    let hours = calendar.component(.hour, from: now)
    let minutes = calendar.component(.minute, from: now)
    return minutes + (hours * 60)
}

let argc = CommandLine.argc

if argc < 2 {
    //DND next 30 minutes
    let start = minutesSinceMidnight()
    let stop = minutesSinceMidnight() + 30

    enableDND(start: Float(start), stop: Float(stop))
    exit(EXIT_SUCCESS)
}

if let arg:Int = Int(CommandLine.arguments[1]) {
    // DND next input minutes
    let start = minutesSinceMidnight()
    var stop = minutesSinceMidnight()

    if arg >= 0 && arg <= 1440 {
        stop = stop + arg
    } else {
        print("Invalid argument given")
        exit(EXIT_FAILURE)
    }

    enableDND(start: Float(start), stop: Float(stop))
    exit(EXIT_SUCCESS)
}

// Should not get to here
print("How did control get to here? It's a mystery")
exit(EXIT_FAILURE)
