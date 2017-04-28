set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" java complete
" Plugin 'artur-shaik/vim-javacomplete2'

" delimitMate (auto complete parenthesis/brackets, .etc)
Plugin 'Raimondi/delimitMate'

" The NERD Tree
Plugin 'scrooloose/nerdtree'

" Plugin 'Valloric/YouCompleteMe'

Plugin 'Rip-Rip/clang_complete'
let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang-3.8.so.1'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" color scheme
syntax enable
syntax on
colorscheme monokai

" smartindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" set title
autocmd BufNewFile *.cpp,*.[ch],*.java exec ":call SetTitle()"
func SetTitle()
    call setline(1, "// @siliconx")
    call append(line("."), "// ".strftime("%Y-%m-%d %T"))
    " call append(line(".")+1, "");
endfunc

" key binding
imap <Alt-h> <left>
imap <Alt-j> <down>
imap <Alt-k> <up>
imap <Alt-l> <right>

" TAB to jump out the parenthesis/brackets, etc
inoremap <Shift-Tab> <esc>la

" make transparent background
hi Normal ctermbg=none

" show line number
set number

" NERDTree config
map <F2> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree  " auto launch NERDTree
autocmd VimEnter * wincmd p  " fous on mian pane

" auto close NERDTree when no active buffer exsit
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()


" ---------------------------------
" F5 to compile and run Java, C, C++, Python, .etc
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "! ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "! ./%<"
  elseif &filetype == 'java' 
    exec "!javac %" 
    exec "!java %<"
  elseif &filetype == 'sh'
    :!./%
  elseif &filetype == 'py'
    exec "!python3 %"
    exec "!python3 %<"
  endif
endfun


"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endfunction
