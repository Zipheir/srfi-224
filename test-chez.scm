;;; SPDX-FileCopyrightText: 2021 Wolfgang Corcoran-Mathe <wcm@sigwinch.xyz>
;;;
;;; SPDX-License-Identifier: MIT

;;; Test framework for ChezScheme

(import (rnrs)
        (srfi :1)
        (srfi :64)
        (srfi :128)
        (srfi :224)
        (only (chezscheme) include))

(include "test-body.scm")
