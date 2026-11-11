; bootstrap lazy.nvim
(local path (.. (vim.fn.stdpath "data") "/lazy/lazy.nvim"))
(when (not (vim.uv.fs_stat path))
  (let [repo "https://github.com/folke/lazy.nvim.git"
        out (vim.fn.system ["git" "clone" "--filter=blob:none" "--branch=stable" repo path])]
    (print out)
    (when (not= 0 vim.v.shell_error)
      (vim.api.nvim_echo [["Failed to clone lazy.nvim:\n" "ErrorMsg"]
                          [out "WarningMsg"]
                          ["\nPress any key to exit..."]]))
    (vim.fn.getchar)
    (os.exit 1)))
(vim.opt.rtp:prepend path)

(require :options)
(local plugins (require :plugins))
(local lazy (require :lazy))

; (print ((. (require :fennel) :view) plugins))

(lazy.setup {:spec plugins})

