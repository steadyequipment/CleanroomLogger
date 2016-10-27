//
//  XcodeColorsTextColorizer.swift
//  CleanroomLogger
//
//  Created by Evan Maloney on 12/18/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

#if os(OSX)
    import Darwin.C.stdio
#elseif os(Linux)
    import Glibc
#endif

/**
 A `TextColorizer` implementation that applies 
 [XcodeColors](https://github.com/robbiehanson/XcodeColors/)-compatible 
 formatting to log messages.
 */
public struct XcodeColorsTextColorizer: TextColorizer
{
    /**
     Initializes a new instance if and only if XcodeColors is installed and
     enabled, as indicated by the presence of the `XcodeColors` environment
     variable. (Unless the value of this variable is the string `YES`, this
     initializer will fail.)
    */
    public init?()
    {
        guard let env = getenv("XcodeColors") else {
            return nil
        }

        guard let str = String(validatingUTF8: env) else {
            return nil
        }

        guard str == "YES" else {
            return nil
        }
    }

    /**
     Applies XcodeColors-style formatting appropriate for the given
     `LogSeverity` to the passed-in string from shared xcodeColorize.

     - parameter string: The string to be colorized.

     - parameter foreground: An optional foreground color to apply to `string`.

     - parameter background: An optional background color to apply to `string`.

     - returns: A version of `string` with the appropriate color formatting
     applied.
     */
    public func colorize(_ str: String, foreground: Color?, background: Color?)
        -> String
    {
        return XcodeColorsTextColorizer.xcodeColorize(str, foreground: foreground, background: background)
    }

    internal static func xcodeColorize(_ str: String, foreground: Color?, background: Color?)
        -> String
    {
        let esc = "\u{001b}["

        var prefix = ""
        var suffix = ""
        if let fgColor = foreground {
            prefix += "\(esc)\(fgColor.xcodeColorsForegroundString);"
            suffix = "\(esc);"
        }
        if let bgColor = background {
            prefix += "\(esc)\(bgColor.xcodeColorsBackgroundString);"
            suffix = "\(esc);"
        }

        return "\(prefix)\(str)\(suffix)"
    }
}

fileprivate extension Color
{
    /// A comma-separated string representation of the red, green and blue
    /// components of the color in base-10 integers.
    var xcodeColorsString: String {
        return "\(r),\(g),\(b)"
    }

    /// An XcodeColors-style string representation usable as a foreground color.
    var xcodeColorsForegroundString: String {
        return "fg\(xcodeColorsString)"
    }

    /// An XcodeColors-style string representation usable as a background color.
    var xcodeColorsBackgroundString: String {
        return "bg\(xcodeColorsString)"
    }
}
