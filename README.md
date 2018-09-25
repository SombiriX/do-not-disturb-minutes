# do-not-disturb-minutes
A Swift 4 script to set the Mac do not disturb feature for a configurable number of minutes, defaults to 30.

## Usage
- For Mac OS (OS X), obviuosly
- Use the [executable](https://github.com/SombiriX/do-not-disturb-minutes/blob/master/executable/dndtime) or build the project with Xcode
- Copy the executable to `/usr/local/bin`
- Run from terminal using eg: `dndtime 55` to turn on do not disturb for 55 minutes
    - Calling with no argument sets the default do not disturb time, 30 minutes
    - Calling with `off` or `0`, disables do not disturb

## Aknowledgment
- This is based on code from this [SO answer](https://stackoverflow.com/a/45645595/6054814), I just added the functionality to set the do not disturb duration and made it executable.

I hope you've found this useful
