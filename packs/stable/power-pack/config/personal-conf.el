;;; personal-conf --- Good emacs configuration for general programming.

;;; Commentary:
;; You will find tha t it is heavily skewed towards my likes.
;; Not specific to any language.

;; Install avy-mode
;; Install flycheck
;; Install python-mode
;; Install markdown mode


;;; Code:


;; --------- Package lists
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
;; --------- </ Package lists

;; ------------- Extend elctric-pair-mode
;; make electric-pair-mode work on more brackets

;; make electric-pair-mode work on more brackets
(electric-pair-mode 1) ;Automatically close left parens. Emacs 24.
(defvar electric-pair-pairs)
(setq electric-pair-pairs '(
                            (?\" . ?\")
                            (?\' . ?\')
                            (?\{ . ?\})
                            (?\[ . ?\])
                            ))

;; ------------- </ Extend elctric-pair-mode


;; --------------- configs
(column-number-mode 1)
(global-set-key [f8] 'toggle-frame-fullscreen) ; Full screen

;; Start in full screen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))


;; Tabs
(setq tab-width 4)
(setq tab-stop-list (number-sequence 4 200 4))
(setq indent-tabs-mode nil)
;; -------------- </ configs

;; ---------------- tramp timeout
; Expand tramp timeout from 5 seconds to 300 seconds
(setq password-cache-expiry 300)
;; ---------------- </ tramp timeout

;; ---------------- eshell
;; eshell
(require 'eshell)
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the current buffer.
The shell is renamed to match that directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)
  ))

(global-set-key (kbd "C-!") 'eshell-here)

(defun eshell/!x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))


(defun eshell/clear ()
  "Clears the shell buffer ala Unix's clear or DOS' cls."
  (interactive)
  ;; the shell prompts are read-only, so clear that for the duration
  (let ((inhibit-read-only t))
	;; simply delete the region
  (eshell-send-input)
	(delete-region (point-min) (point-max))))

(provide 'my-eshell)
;; --------------- </ eshell

;;; my-programming-mode-conf ends here.
