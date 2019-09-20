syntax on

" set backup
" set backupdir=C:\WINDOWS\Temp
" set backupskip=C:\WINDOWS\Temp\* 
" set directory=C:\WINDOWS\Temp
" set writebackup

set tabstop=4
set shiftwidth=4
set expandtab

colorscheme desert

" 1. Install VcXsrv (if it starts after installing, stop it).
" 2. Start it using the newly installed program XLaunch (search in the start menu).
" 3. Go with all the defaults options, and ensure the clipboard options are checked.
" 4. At the end, save the configuration to a file, config.xlaunch (use that to start it from now on).
" 5. Put export DISPLAY=localhost:0.0 in your .bashrc in bash for Windows and run source ~/.bashrc in any open terminal.
" 6. Ensure vim is installed using clipboard support. vim --version | grep clipboard should say +clipboard, not -clipboard. Also if you run the ex command :echo has('clipboard') in vim and it says 0 it does not have clipboard support compiled in.
" 7. If you don't have clipboard support, install a vim package compiled with clipboard support, e.g. apt-get install vim-gtk.
" 8. Now you can access the Windows system clipboard via "*p and "*y, or set it to default by putting set clipboard=unnamed in your .vimrc file.
set clipboard=unnamed

" plugin stuff
execute pathogen#infect()
call pathogen#helptags()
" plugin:nerdtree:https://github.com/scrooloose/nerdtree
" ## Turned off auto-on feature of nerdtree: autocmd vimenter * NERDTree 
map <C-n> :NERDTreeToggle<CR>

" highlight search patterns
:set hlsearch

:set mouse=a
