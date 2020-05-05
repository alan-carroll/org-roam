;;; org-roam-doctor.el --- Rudimentary Roam replica with Org-mode -*- coding: utf-8; lexical-binding: t; -*-
;;
;; Copyright © 2020 Jethro Kuan <jethrokuan95@gmail.com>

;; Author: Jethro Kuan <jethrokuan95@gmail.com>
;; URL: https://github.com/jethrokuan/org-roam
;; Keywords: org-mode, roam, convenience
;; Version: 1.1.0
;; Package-Requires: ((emacs "26.1") (dash "2.13") (f "0.17.2") (s "1.12.0") (org "9.3") (emacsql "3.0.0") (emacsql-sqlite "1.0.0"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; This library provides utilities for ensuring that Org-roam files are kept in
;; a pristine state.
;;
;;; Code:
;;;; Library Requires

(defun org-roam-doctor-broken-links ()
  "Displays broken links in a side window."
  (interactive)
  (dolist (file (org-roam--list-all-files))
    (let ((f (find-file file)))
      (with-current-buffer f
        (goto-char (point-min))
        (while (re-search-forward link-regexp nil t)
          (let ((link (match-string 2)))
            (when (s-prefix? "file:" link)
              (setq link (s-chop-prefix "file:" link))
              (when (and (org-roam--org-roam-file-p link)
                         (not (file-exists-p link)))
                (message link)))))))))

(provide 'org-roam-doctor)

;;; org-roam-doctor.el ends here
