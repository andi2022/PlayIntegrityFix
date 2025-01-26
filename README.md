# Play Integrity Fix

This module tries to fix Play Integrity and SafetyNet verdicts to get a valid attestation.
It's an automatic copy of the original module from [chiteroman](https://github.com/chiteroman/PlayIntegrityFix) with modifications for the PoGO mapping community.

The following setting has been modified in the PlayIntegrityFix module.
`ro.adb.secure 0`

The repository checks every 20 minutes if a new module exist. If a new module is available it will download, patch the module and rerelease the modified version.


## Download
[https://github.com/andi2022/PlayIntegrityFix/releases/latest](https://github.com/andi2022/PlayIntegrityFix/releases/latest)