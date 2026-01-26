;; -*- mode: emacs-lisp; lexical-binding: t -*-

;; ---------------------------------------
;; General Configuration changes
;; ---------------------------------------

;; ---------------------------------------
;; Line numbers
;; native line numbers taking up lots of space?
(setq-default display-line-numbers-width nil)
;; ---------------------------------------

;; ---------------------------------------
;; Searching
;; replace / search with helm-swoop in Evil normal state
(evil-global-set-key 'normal "/" 'helm-swoop)
;;
;; ---------------------------------------

;; ---------------------------------------
;; Evil escape
(setq-default evil-escape-key-sequence "jk")
;;
;; ---------------------------------------

;; Set window size
(setq resize-factor-small 0.75)
(setq resize-factor-big 0.50)
(setq width-breakpoint 1440)
(setq pos-adjustment 6)
(setq height-adjustment 4)
(when window-system
  (let ((frame (selected-frame))
        (resized-height (- (/ (display-pixel-height) (frame-char-height)) height-adjustment))
        (resized-width (let ((resized-width (-  (/ (display-pixel-width) (frame-char-width)) pos-adjustment)))
                         (if (> (display-pixel-width) width-breakpoint)
                             (round (* resized-width resize-factor-big))
                           (round (* resized-width resize-factor-small))
                           ))))
    (set-frame-height frame resized-height)
    (set-frame-width frame resized-width)
    (set-frame-position frame
                        (if (> (display-pixel-width) width-breakpoint)
                            (+ (- (display-pixel-width) (round (* (display-pixel-width) resize-factor-big))) pos-adjustment)
                          0)
                        0))
  )

;; ---------------------------------------
;;
;; Evil Safe Lisp Structural Editing
;;
;; https://www.spacemacs.org/layers/+lang/racket/README.html#structurally-safe-editing
;; ---------------------------------------
(spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hooks)

;; ---------------------------------------
;;
;; Org publish
;;
;; https://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html
;; ---------------------------------------
(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("org-notes"
         :base-directory "~/Documents/org-roam/"
         :base-extension "org"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :auto-preamble t
         )
        ("org-static"
         :base-directory "~/Documents/org-roam/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("org"
         :components ("org-notes" "org-static"))
        ))

;; ---------------------------------------
;; Helm Descbinds
;; Recent release of helm-descbinds package breaks which-key menu
;; Remove helm-discbinds-mode from helm mode hook to avoid activating
;; https://github.com/syl20bnr/spacemacs/issues/16276
(remove-hook 'helm-mode-hook 'helm-descbinds-mode)
;; ---------------------------------------
