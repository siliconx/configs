" ===========Vundle设置===========
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required. 插件管理工具
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" 括号补全
Plugin 'Raimondi/delimitMate'

" 树形目录
Plugin 'scrooloose/nerdtree'

" 自动补全
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ===========颜色主题===========
syntax enable
syntax on
" make transparent background
hi Normal ctermbg=none
" show line number
set number
" colorscheme monokai


" ===========智能缩进===========
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" ===========显示空白===========
set listchars=tab:>-,trail:-
set list

" ===========自动填入代码基础信息===========
autocmd BufNewFile *.cpp,*.[ch],*.java exec ":call SetTitle()"
func SetTitle()
    call setline(1, "// siliconx@163.com")
    call append(line("."), "// ".strftime("%Y-%m-%d %T"))
    " call append(line(".")+1, "");
endfunc

" ===========键位绑定===========
" 跳出括号，仅插入模式有效
inoremap <Shift-Tab> <esc>la

" ===========NERDTree配置===========
map <F2> :NERDTreeToggle<CR>  " F2打开或关闭目录
autocmd vimenter * NERDTree  " auto launch NERDTree
autocmd VimEnter * wincmd p  " fous on mian pane
let NERDTreeWinSize=20  " 宽度为20个字符

" auto close NERDTree when no active buffer exsit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ===========F5编译运行===========
map <F5> :call CompileRun()<CR>
func! CompileRun()
  exec "w"
  if &filetype == 'c'
    exec "!gcc % -o %<"
    exec "! ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "! ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!java %<"
  elseif &filetype == 'python'
    exec "!python3 %"
  elseif &filetype == 'sh'
    :!./%
  elseif &filetype == 'dot'
      exec "!dot % -Kfdp -T png -o %<"
  endif
endfun

