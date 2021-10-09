# Features that are not yet functional

* Using SSH Servers other than OpenSSH. A "--ssh-server" option was added
  with values "dropbear", "openssh", and "tinyssh" that does install and
  enable the appropriate daemon. However cloud-init does not presently support
  SSH servers other than OpenSSH - I am working on a cloud-init patch to
  support this.

* Bootcharts is not working currently.
