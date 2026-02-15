;; Store auto-save and backup files in temp directory
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

;; Magit configuration
;; Make magit-status use the full frame
(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
