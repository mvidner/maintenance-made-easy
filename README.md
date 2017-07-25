mme: Maintenance Made Easy
==========================

Package, build and release [YaST](http://yast.github.io/) maintenance
updates for SUSE Linux Enterprise 11 and 10.

(For SLE 12 a [better mechanism based on Jenkins CI][jci] is already in place)

[jci]: http://yastgithubio.readthedocs.org/en/latest/development/#automatic-submission

It uses OBS (openSUSE Build Service), and Git. It builds in a chroot without
needing virtual machines.

Installation
------------

```
git clone https://github.com/mvidner/maintenance-made-easy.git
cd maintenance-made-easy
make install-links
```

It will link the programs from the working copy to your `$HOME/bin`.

Usage
-----

Prepare a fix in your Git working copy, commit it. Pushing or merging is not
required for this script so you can test unreleased fixes.

```sh
cd .../your-working-copy
mme-all sp4
```

The required argument is the target release. The full option menu is:

```
Usage: mme-all [options] SHORT_PRJ [build options]

 where SHORT_PRJ is sp4 or sp3 (for SLE11), sle10sp4 ...

Options:
 -h  Help
 -r <RPM name>; defaults to contents of RPMNAME
 -g <git URL> clone from here instead;
              defaults to CWD if .git/ exists
 -B  Don't branch the OBS project

Build options:
  anything for 'osc build'; --no-verify or -x strace may be useful
```

Operation
---------

The script will read RPMNAME and check out the latest good package from IBS
(to `~/obs/$REPO/$RPMNAME`). Actually it will branch the OBS package first so
that you can then commit and submit your package, once the fix is confirmed to
be good. If you are just testing a colleague's fix you may want to skip the
branch with `mme-all -B`.

It will build the old version of the package to fill the build root with
proper dependencies.

It will clone the working copy into the chroot, using your UID, to make ad-hoc
edits and fixes easier.

It will make a package via `make package-local` in the chroot and copy the
result to the OBS checkout.

It will call `osc build`.

If the build *succeeded*, you should proceed to call `osc ci` and `osc sr`
by hand. This is **not automatic**.
(But remember to merge the reviewed fix in Git first.)

If the build *failed*, call `mme-chroot` and select the appropriate build root
from a menu to get a shell where you can enjoy debugging.

About
-----

Author: Martin Vidner

License: MIT
