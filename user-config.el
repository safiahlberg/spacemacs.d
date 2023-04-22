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

;; Set window size
(setq resize-factor 0.45)
(setq width-breakpoint 1440)
(setq pos-adjustment 0)
(when window-system
  (let ((frame (selected-frame))
        (resized-height (- (/ (display-pixel-height) (frame-char-height)) 2))
        (resized-width (let ((resized-width (-  (/ (display-pixel-width) (frame-char-width)) pos-adjustment)))
                         (if (> (display-pixel-width) width-breakpoint)
                             (round (* resized-width resize-factor))
                           resized-width))))
    (set-frame-height frame resized-height)
    (set-frame-width frame resized-width)
    (set-frame-position frame
                        (if (> (display-pixel-width) width-breakpoint)
                            (+ (- (display-pixel-width) (round (* (display-pixel-width) resize-factor))) pos-adjustment)
                          0) 0))
  )
