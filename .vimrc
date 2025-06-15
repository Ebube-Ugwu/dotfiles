" designed for vim 8+

if has("eval")                               " vim-tiny lacks 'eval'
  let skip_defaults_vim = 1
endif

set nocompatible

"#################### Vi Compatible (~/.exrc) #######################
"

" automatically indent new lines
set autoindent " (alpine)

"set noflash " (alpine-ish only)

" replace tabs with spaces automatically
set expandtab " (alpine)

" number of spaces to replace a tab with when expandtab
set tabstop=2 " (alpine)

" use case when searching
set noignorecase

" automatically write files when changing when multiple files open
set autowrite

" always yank to system register
set clipboard=unnamedplus

" relative line numbers
set relativenumber

" turn col and row position on in bottom right
set ruler " see ruf for formatting

" show command and insert mode
set showmode

"###################################################################

" disable bell (also disable in .inputrc)
set noerrorbells
set visualbell
set vb t_vb=

let mapleader=" "

set softtabstop=2

" mostly used with >> and <<
set shiftwidth=2

set smartindent

set smarttab

if v:version >= 800
  " stop vim from silently messing with files that it shouldn't
  set nofixendofline

  " better ascii friendly listchars
  set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

  " i hate automatic folding
  set foldmethod=manual
  set nofoldenable
 "set foldenable
  "set foldmethod=syntax
  "set foldlevelstart=99  " Open all folds by default
endif

" mark trailing spaces as errors (break Makefiles, etc.)
match Visual '\s\+$'

" enough for line numbers + gutter within 80 standard
set textwidth=72
"set colorcolumn=73

" disable relative line numbers, remove no to sample it
set relativenumber

" disable spellcapcheck
set spc=

" more risky, but cleaner
set nobackup
set noswapfile
set nowritebackup

set icon

" highlight search hits
set hlsearch
set incsearch
set linebreak

" avoid most of the 'Hit Enter ...' messages
set shortmess=aoOtTI

" prevents truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000

" not a fan of bracket matching or folding
if has("eval") " vim-tiny detection
  let g:loaded_matchparen=1
endif
set noshowmatch

" wrap around when searching
set wrapscan
set nowrap

" Just the formatoptions defaults, these are changed per filetype by
" plugins. Most of the utility of all of this has been superceded by the
" use of modern simplified pandoc for capturing knowledge source instead
" of arbitrary raw text files.


" stop complaints about switching buffer with changes
set hidden

" command history
set history=100

" here because plugins and stuff need it
if has("syntax")
  syntax enable
endif

" faster scrolling
set ttyfast

" allow sensing the filetype
filetype plugin on

" high contrast for streaming, etc.
set background=dark

set cinoptions+=:0

" --------------------------------
" MY REMAPS
" --------------------------------
" Edit/Reload vimrc configuration file
nnoremap <Leader>ev :e $HOME/.vimrc<CR>
nnoremap <Leader>sv :source $HOME/.vimrc<CR>

" Open todofile
nnoremap <Leader>td :e $HOME/TODO.md<CR>

" save and quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" open nerdtree
nnoremap <leader>E :NERDTree<cr>

" Cycle through buffers
nnoremap <tab> :bn<cr>
nnoremap <S-Tab> :bp<cr>

set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" only load plugins if Plug detected
if filereadable(expand("~/.vim/autoload/plug.vim"))

  " github.com/junegunn/vim-plug
  " There can only be one plug#begin block so all this
  " has to be here instead of split into init.lua as well.
  call plug#begin('~/.local/share/vim/plugins')
    Plug 'conradirwin/vim-bracketed-paste'
    Plug 'sainnhe/gruvbox-material'
    Plug 'fatih/vim-go' " GoInstallBinaries separately
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'rwxrob/vim-pandoc-syntax-simple'
    Plug 'habamax/vim-asciidoctor'
    "Plug 'kana/vim-textobj-user'
    Plug 'mjakl/vim-asciidoc'
    Plug 'dense-analysis/ale'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'Raimondi/delimitMate'
    Plug  'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mhinz/vim-startify'
    if has('nvim-0.8')
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
      if exists('$NVIM_SCREENKEY')
        Plug 'NStefan002/screenkey.nvim'
      endif
    endif
    if has('nvim')
      Plug 'xolox/vim-misc'
      Plug 'xolox/vim-lua-ftplugin'
    else
      Plug 'dahu/vim-asciidoc'
    endif
    call plug#end()

    let g:vim_asciidoc_initial_foldlevel=1

    set signcolumn=yes
    let g:ale_set_signs = 1
    let g:ale_sign_info = '✨'
    let g:ale_sign_error = '🔥'
    let g:ale_sign_warning = '❗️'
    let g:ale_sign_hint = '💡'

    " perl stuff needs cpan install (brew also works):
    "   Perl::Tidy
    "   Perl::Critic

    let g:ale_linters = {
          \'go': ['gometalinter','gofmt','gobuild'],
          \'perl': ['perl','perlcritic'],
          \}
    let g:ale_linter_aliases = {'bash': 'sh'}
    let g:ale_perl_perlcritic_options = '--severity 3'

    let g:ale_fixers = {
          \'sh': ['shfmt'],
          \'bash': ['shfmt'],
          \'perl': ['perltidy'],
          \}
    let g:ale_fix_on_save = 1
    let g:ale_perl_perltidy_options = '-b'

    " pandoc
    let g:pandoc#formatting#mode = 'h' " A'
    let g:pandoc#formatting#textwidth = 72

    " golang
    let g:go_fmt_fail_silently = 0
    "let g:go_fmt_options = '-s'
    let g:go_fmt_command = 'goimports'
    let g:go_fmt_autosave = 1
    let g:go_gopls_enabled = 1
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_variable_declarations = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_diagnostic_errors = 1
    let g:go_highlight_diagnostic_warnings = 1
    let g:go_code_completion_enabled = 1
    let g:go_auto_sameids = 0
    set updatetime=100


    if !exists('g:colors_name') || g:colors_name !=# 'gruvbox-material'
      try
        colorscheme gruvbox-material
      catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme desert
      endtry
    endif

else
  autocmd vimleavepre *.go !gofmt -w % " backup if fatih fails
  endif

  " force loclist to always close when buffer does (affects vim-go, etc.)
  augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
  augroup END

  autocmd BufWritePost *.{md,adoc} silent !toemoji %

  " make Y consistent with D and C (yank til end)
  map Y y$

  " better command-line completion
  set wildmenu

  " better cursor movement
  "set virtualedit=all
  set wrap

  " disable search highlighting with <C-L> when refreshing screen
  nnoremap <C-L> :nohl<CR><C-L>

  " enable omni-completion
  set omnifunc=syntaxcomplete#Complete
  imap <tab><tab> <c-x><c-o>

  " force some files to be specific file type
  au bufnewfile,bufRead .goreleaser set ft=yaml
  au bufnewfile,bufRead *.props set ft=jproperties
  au bufnewfile,bufRead *.ddl set ft=sql
  au bufnewfile,bufRead *.sh* set ft=sh
  au bufnewfile,bufRead *.{peg,pegn} set ft=config
  au bufnewfile,bufRead *.gotmpl set ft=go
  au bufnewfile,bufRead *.profile set filetype=sh
  au bufnewfile,bufRead *.crontab set filetype=crontab
  au bufnewfile,bufRead *ssh/config set filetype=sshconfig
  au bufnewfile,bufRead .dockerignore set filetype=gitignore
  au bufnewfile,bufRead .bashrc,.bash_profile set filetype=bash
  au bufnewfile,bufRead *gitconfig set filetype=gitconfig
  au bufnewfile,bufRead /tmp/psql.edit.* set syntax=sql
  au bufnewfile,bufRead *.go set spell spellcapcheck=0
  au bufnewfile,bufRead commands.yaml set spell
  au bufnewfile,bufRead *.{txt,md,adoc} set spell

  "fix bork bash detection
  if has("eval")  " vim-tiny detection
    fun! s:DetectBash()
      if getline(1) == '#!/usr/bin/bash' 
            \ || getline(1) == '#!/bin/bash'
            \ || getline(1) == '#!/usr/bin/env bash'
        set ft=bash
        set shiftwidth=2
      endif
    endfun
    autocmd BufNewFile,BufRead * call s:DetectBash()
  endif

  " displays all the syntax rules for current position, useful
  " when writing vimscript syntax plugins
  if has("syntax")
    function! <SID>SynStack()
      if !exists("*synstack")
        return
      endif
      echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunc
  endif

  " start at last place you were editing
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " functions keys
  map <F1> :set number!<CR> :set relativenumber!<CR>
  nmap <F2> :call <SID>SynStack()<CR>
  set pastetoggle=<F3>
  map <F4> :set list!<CR>
  map <F5> :set cursorline!<CR>
  map <F7> :set spell!<CR>
  map <F12> :set fdm=indent<CR>

  set cursorline


  " disable arrow keys (vi muscle memory)
  noremap <up> :echoerr "Umm, use k instead"<CR>
  noremap <down> :echoerr "Umm, use j instead"<CR>
  noremap <left> :echoerr "Umm, use h instead"<CR>
  noremap <right> :echoerr "Umm, use l instead"<CR>
  inoremap <up> <NOP>
  inoremap <down> <NOP>
  inoremap <left> <NOP>
  inoremap <right> <NOP>

  " better page down and page up
  noremap <C-n> <C-d>
  noremap <C-p> <C-b>

  " set TMUX window name to name of file
  if exists('$TMUX')
    autocmd BufEnter * call system('tmux rename-window ' . expand('%:p:h:t') . '/' . expand('%:t'))
  endif

  " set cursor change depending on mode type (only on supported terminal
  " emulators

  if &term =~ "xterm\\|rxvt\\|wezterm\\|alacritty"
    let &t_SI = "\e[6 q" " Insert mode: I-beam
    let &t_EI = "\e[2 q" " Normal mode: block
    let &t_SR = "\e[4 q"  " Replace mode: underline
  endif

" vim airline themes and config
let g:airline_theme='simple'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

" vim colorsheme
colorscheme gruvbox
