;; Startup optimizations
;;
;; https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/

;; Set garbage collection threshold

(setq gc-cons-threshold (* 1024 1024 100))

;; Set file-name-handler-alist

(setq file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Keep tabs on startup time

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(run-with-idle-timer
   5 nil
   (lambda ()
     (setq gc-cons-threshold (* 1024 1024 20))
     (setq file-name-handler-alist file-name-handler-alist-original)
     (makunbound 'file-name-handler-alist-original)))

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Always show line numbers
(global-display-line-numbers-mode 1)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Write all autosave files in the tmp dir
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Color all language features
(setq font-lock-maximum-decoration t)

;; Include entire file path in title
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

;; Be less obnoxious
(blink-cursor-mode -1)
(tooltip-mode -1)

;; Don't beep. Just blink the modeline on errors.
(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))

;; UTF-8 please
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Always display column numbers
(setq column-number-mode t)

;; Highlight current line
(global-hl-line-mode 1)

;; Don't zoom individual buffers
(global-unset-key (kbd "C-x C-+"))

;; Disable zooming with pinch / mouse wheel
;;
;; In addition to zooming with `C-x C-+` and `C-x C--`, there's a different,
;; buffer specific zoom that zooms insanel fast.
(global-set-key (kbd "<pinch>") 'ignore)
(global-set-key (kbd "C-<wheel-up>") 'mwheel-scroll)
(global-set-key (kbd "C-<wheel-down>") 'mwheel-scroll)

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; We use git. Don't try all the other VC systems in existence first.
(setq vc-handled-backends '(Git))

;; Don't write lock-files, I'm the only one here
(setq create-lockfiles nil)

;; Move files to trash when deleting
(setq delete-by-moving-to-trash t)

;; Offer to create parent directories if they do not exist
;; http://iqbalansari.github.io/blog/2014/12/07/automatically-create-parent-directories-on-visiting-a-new-file-in-emacs/
(defun my-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))

(add-to-list 'find-file-not-found-functions 'my-create-non-existent-directory)

;; Magit configuration
(use-package magit
  :defer t

  :custom
  (magit-section-initial-visibility-alist '((untracked . show)
                                            (unstaged . show)
                                            (unpushed . show)
                                            (unpulled . show)
                                            (stashes . show)))
  (magit-diff-refine-hunk t)
  (magit-revert-buffers 'silent)
  (magit-no-confirm '(stage-all-changes
                      unstage-all-changes))

  :bind (("C-x m" . magit-status)))

;; Make magit-status use the full frame
(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)