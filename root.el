(defun my/project-find-root ()
  (let ((root (or (locate-dominating-file default-directory "Makefile")
                  (locate-dominating-file default-directory "Cargo.toml")
                  (locate-dominating-file default-directory "go.mod")
                  (locate-dominating-file default-directory "CMakeLists.txt")
                  default-directory)))
    (expand-file-name root)))

(defun my/project-compile ()
  (interactive)
  (let ((default-directory (my/project-find-root)))
    (call-interactively 'compile)))

(global-set-key [remap project-compile] 'my/project-compile)
