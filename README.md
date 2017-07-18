# 8R-LowBatteryWarning

## What is it?

This is a utility script for warn when the computer battery is low. It too can shutdown the pc, case the battery is low and the pc not is connected to an energy font.

## Using 8R-LowBatteryWarning

[Download](https://github.com/InfinityRefactoring/8R-LowBatteryWarning/archive/master.zip) the source code

Extract to the `/opt/8R-LowBatteryWarning/` folder

Add the two below lines in the end of `/etc/sudoers` file.

```
# 8R-LowBatteryWarning
USER_NAME ALL = NOPASSWD: /usr/sbin/pm-suspend
```

*Note*: Replace USER_NAME by the user name that will use this script.

Set the permissions to execute the script file and the .ogg file.

Put this script to initialize with system. Example:

```
Name: 8R-LowBatteryWarning
Command: /opt/8R-LowBatteryWarning/LowBatteryWarning.sh
Comment: Notify the user when the battery level is low.
Delay: 50
```

*Note*: If you desire change the default config you can change the variables defined in the LowBatteryWarning.sh file.

## Tested on

* Linux mint - 18.2

## Licensing

**8R-LowBatteryWarning** is provided and distributed under the [Apache Software License 2.0](http://www.apache.org/licenses/LICENSE-2.0).

Refer to *LICENSE* for more information.
