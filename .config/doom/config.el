;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Drew Vlasnik"
      user-mail-address "314dsv@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; test
(setq doom-font (font-spec :family "Hack" :size 26)
      doom-variable-pitch-font (font-spec :family "sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-molokai)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/.config/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#222323" "#e74c3c" "#b6e63e" "#e2c770" "#268bd2" "#fb2874" "#66d9ef" "#d6d6d4"])
 '(custom-safe-themes
   (quote
    ("25f1b2ace87d23d803b42267fafdc38b31472e444c2aaa9069aa2c06be8955b2" "912cac216b96560654f4f15a3a4d8ba47d9c604cbc3b04801e465fb67a0234f0" "1897b97f63e91a792e8540c06402f29d5edcbfb0aafd64b1b14270663d6868ee" "5c9a906b076fe3e829d030a404066d7949e2c6c89fc4a9b7f48c054333519ee7" "dc677c8ebead5c0d6a7ac8a5b109ad57f42e0fe406e4626510e638d36bcc42df" "92d8a13d08e16c4d2c027990f4d69f0ce0833c844dcaad3c8226ae278181d5f3" "15ba8081651869ec689c9004288bed79003de5b4ee9c51a9d4a208d9e3439706" default)))
 '(fci-rule-color "#555556")
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#fd971f"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#b6e63e"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#525254"))
 '(objed-cursor-color "#e74c3c")
 '(pdf-view-midnight-colors (cons "#d6d6d4" "#1c1e1f"))
 '(rustic-ansi-faces
   ["#1c1e1f" "#e74c3c" "#b6e63e" "#e2c770" "#268bd2" "#fb2874" "#66d9ef" "#d6d6d4"])
 '(vc-annotate-background "#1c1e1f")
 '(vc-annotate-color-map
   (list
    (cons 20 "#b6e63e")
    (cons 40 "#c4db4e")
    (cons 60 "#d3d15f")
    (cons 80 "#e2c770")
    (cons 100 "#ebb755")
    (cons 120 "#f3a73a")
    (cons 140 "#fd971f")
    (cons 160 "#fc723b")
    (cons 180 "#fb4d57")
    (cons 200 "#fb2874")
    (cons 220 "#f43461")
    (cons 240 "#ed404e")
    (cons 260 "#e74c3c")
    (cons 280 "#c14d41")
    (cons 300 "#9c4f48")
    (cons 320 "#77504e")
    (cons 340 "#555556")
    (cons 360 "#555556")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
