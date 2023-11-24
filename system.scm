;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (srfi srfi-1)
	     (gnu system nss)
	     (gnu packages wm)
	     (gnu packages fonts)
	     (gnu packages file-systems)
	     (gnu packages shells)
	     (gnu packages freedesktop)
	     (gnu packages lisp)
	     (gnu packages lisp-xyz)
	     (gnu packages emacs)
	     (gnu packages vim)
	     (gnu packages parallel)
	     (gnu packages rsync)
	     (gnu packages wget)
	     (gnu packages mtools)
	     (gnu packages xorg)
	     (gnu packages gnome)
	     (gnu packages linux)
	     (gnu packages audio)
	     (gnu packages gnuzilla)
	     (gnu packages pulseaudio)
	     (gnu packages web-browsers)
	     (gnu packages version-control)
	     (gnu packages package-management)
	     (nongnu packages linux)
	     (nongnu system linux-initrd))
(use-service-modules pm sound networking ssh dbus desktop xorg)

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "America/Chicago")
  (keyboard-layout (keyboard-layout "jp,us"
                                    #:options '("grp:alt_shift_toggle")))
  (host-name "Panasonic-Guix")  
  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "izder456")
                  (comment "the srcerizder")
                  (group "users")
                  (home-directory "/home/izder456")
                  (supplementary-groups '("wheel"
					  "netdev"
					  "audio"
					  "video"
					  "cdrom"))
		  (shell (file-append zsh "/bin/zsh")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "xterm")
                          (specification->package "emacs")
                          (specification->package "nss-certs")
			  ntfs-3g exfat-utils fuse-exfat zsh
			  neovim git pulseaudio tlp
			  setxkbmap xrdb xfontsel
			  xdg-utils xdg-user-dirs
			  gvfs parallel wget rsync 
                          sbcl sbcl-clx sbcl-clx-truetype
			  font-spleen `(,font-spleen "otf") 
                          font-gnu-unifont
                          font-liberation font-gnu-freefont
			  stumpwm `(,stumpwm "lib"))
		    %base-packages))
	    

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services (cons*
                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                 (service tor-service-type)
                 (service network-manager-service-type)
                 (service wpa-supplicant-service-type)
		 (service alsa-service-type
			  (alsa-configuration
			   (pulseaudio? #t)))
                 (service ntp-service-type)
                 (service gpm-service-type)
		 (service dbus-root-service-type)
		 (service slim-service-type)
		 (service tlp-service-type
			  (tlp-configuration
			   (cpu-boost-on-ac? #t)
			   (wifi-pwr-on-bat? #t)))
		 (extra-special-file "/usr/bin/env"
				     (file-append coreutils "/bin/env"))
		 (service thermald-service-type)
		 %base-services))
  
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "266880cd-0335-4b04-b064-4b4df6b045b4"))
                          (target "guix")
                          (type luks-device-mapping))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device "/dev/mapper/guix")
                         (type "ext4")
                         (dependencies mapped-devices))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "AAFB-CDFA"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
