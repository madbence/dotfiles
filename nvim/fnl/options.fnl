(set vim.g.mapleader ",")
(set vim.g.maplocalleader "\\")
(set vim.opt.number true)
(set vim.opt.relativenumber true)
(set vim.opt.scrolloff 7)
(set vim.opt.wildignore [:*.o "*~" :*.toc :*.aux :*.tos :*.nav :*.pdf :*.out])
(set vim.opt.ignorecase true)
(set vim.opt.smartcase true)
(set vim.opt.lazyredraw true)
(set vim.opt.termguicolors true)
(set vim.opt.swapfile false)
(set vim.opt.expandtab true)
(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.softtabstop 2)
(set vim.opt.list true)
(set vim.opt.listchars {:eol "¬" :tab "»·" :trail "·"})
(set vim.opt.signcolumn :yes)
(set vim.opt.colorcolumn [:80])
(set vim.opt.completeopt [:menu :menuone :noselect])
(set vim.opt.mouse {})

; Keep selection after indenting.
(vim.api.nvim_set_keymap :v "<" :<gv {:noremap true :silent true})
(vim.api.nvim_set_keymap :v ">" :>gv {:noremap true :silent true})
; Navigate between splits.
(vim.api.nvim_set_keymap :n :<C-j> :<C-W>j {:noremap true :silent true})
(vim.api.nvim_set_keymap :n :<C-k> :<C-W>k {:noremap true :silent true})
(vim.api.nvim_set_keymap :n :<C-h> :<C-W>h {:noremap true :silent true})
(vim.api.nvim_set_keymap :n :<C-l> :<C-W>l {:noremap true :silent true})
; Move by visual lines.
(vim.api.nvim_set_keymap :n :j :gj {:noremap true :silent true})
(vim.api.nvim_set_keymap :n :k :gk {:noremap true :silent true})
; Edit the canonical options file.
(vim.api.nvim_set_keymap :n :<leader>ev
                         (.. ":e " (vim.fn.fnameescape (.. (vim.fn.stdpath :config) "/fnl/options.fnl")) "<CR>")
                         {:noremap true :silent true})

; Restore the last cursor position, except in commit and rebase buffers.
(vim.api.nvim_create_autocmd :BufWinEnter
                             {:callback (fn [args]
                                          (local position (vim.api.nvim_buf_get_mark args.buf "\""))
                                          (local filetype (. vim.bo args.buf :filetype))
                                          (when (and (not (filetype:find "commit"))
                                                     (not (filetype:find "rebase"))
                                                     (> (. position 1) 1)
                                                     (<= (. position 1) (vim.api.nvim_buf_line_count args.buf)))
                                            (local winid (vim.fn.bufwinid args.buf))
                                            (pcall vim.api.nvim_win_set_cursor winid position)))
                              :desc "Auto jump to last position"
                              :group (vim.api.nvim_create_augroup :auto-last-position
                                                                  {:clear true})})

(vim.api.nvim_create_autocmd :FocusLost
                             {:callback (fn [] (vim.cmd ":wa"))
                              :group (vim.api.nvim_create_augroup :auto_save {})})
