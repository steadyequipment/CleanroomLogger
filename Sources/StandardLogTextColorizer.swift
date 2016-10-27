//
//  StandardLogTextColorizer.swift
//  CleanroomLogger
//
//  Created by Ian Grossberg on 10/26/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

/**
 A standard `TextColorizer` based on Xcode colors.
 */
public struct StandardLogTextColorizer: TextColorizer
{
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
}
