# early-init

Minimal init system to run tasks before the real init process start on embedded systems.

### License

MIT

### Authors

- Alexandre Grosset
- Christophe Blaess

The aim of this small project is to easily run custom tasks during the boot of an embedded system before starting `systemd`, `sysvinit`, `openrc`, or any other init daemon.

The main idea is to divide the initialization tasks on two parts: the low-level tasks that need to be run at the very start of the boot, in a certain order, with a predictible behavior, and the high-level tasks that are needed to run custom code on the embedded system.

A fully predictible order of task execution is difficult to achieve with `systemd` for example, but `systemd` may be needed to run custom code with a lot of dependencies (D-bus...).

The idea is to let the kernel start `early-init` with the help of the `init=` directive of the kernel command line.
Then `early-init` executes in order the scripts found in `/etc/early-init.d`.
Finally `early-init` gives the control to the original `/sbin/init` process.

Some command line options are available to configure `early-init`.

- The option `-v` (`--verbose`) let `early-init` display what it does on the standard error output.

- With the option `-n` (`--dry-run`), `early-init` doesn't run its scripts, only displays their names.

- The option `-i <filename>` (`--init <filename>`) allows `early-init` to execute an init process different than `/sbin/init` (for example `/bin/sh` for debug).

