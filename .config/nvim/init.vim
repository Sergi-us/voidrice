let mapleader =","
" SARBS 0.4
" TODO das 'q' dilemma Überdenken...
" TODO Alle Bindings und Funktionen in MOD+F1 eintragen

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

map ,, :keepp /<++><CR>ca<
imap ,, <esc>:keepp /<++><CR>ca<

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
call plug#end()

" Setzt den Fenstertitel (nützlich für Terminalemulator-Tabs)
	set title
" (light dark) Setzt den Hintergrund auf 'hell' oder dunkel.
	set bg=dark
" Aktiviert alle GUI-Optionen (für gVim/Neovim-GUI)
	set go=a
" Aktiviert Mausunterstützung in allen Modi
	set mouse=a
" Deaktiviert die Hervorhebung von Suchergebnissen
	set nohlsearch
" Fügt das System-Clipboard zur unbenannten Registrierung hinzu (für Copy & Paste)
	set clipboard+=unnamedplus
" Versteckt die Modusanzeige (da oft durch Plugins wie Airline ersetzt)
	set noshowmode
" Deaktiviert die Anzeige von Zeilen- und Spaltennummer unten rechts
	set noruler
" Deaktiviert die Statusleiste (0=nie, 2=immer, 1=nur bei mehreren Fenstern)
	set laststatus=0
" Versteckt die Anzeige von (unvollständigen) Befehlen in der letzten Zeile
	set noshowcmd
" voreingestelltes Farbschema
	colorscheme vim
	" colorscheme desert  	" kontrastreiche Farbschema (transprenz verschwindet)
" ändert das verhalten der Taste "c" in Normal Mode. Gelöschter Text wird in das "Black Hole" -Register geschoben, wenn Sie Text löschen möchten, ohne den Inhalt der Zwischenablage zu ändern.
	nnoremap c "_c
" Aktiviert die Erkennung von Dateitypen und lädt entsprechende Plugins.
	filetype plugin on
" Aktiviert die Syntax-Hervorhebung.
	syntax on
" Setzt die Zeichenkodierung auf UTF-8
	set encoding=utf-8
" Aktiviert die Zeilennummerierung mit einer Kombination aus absoluten und relativen Nummern.
	set number relativenumber
" Ativiert und steuert das Verhalten der Befehlszeilen-Vervollständigung.
	set wildmode=longest,list,full
" Verhindert, dass Vim automatisch Kommentarzeichen in neue Zeilen einfügt.
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Punkt-Befehle über visuelle Blöcke ausführen
	vnoremap . :normal .<CR>
" Goyo-Plugin für bessere Lesbarkeit beim Schreiben:
	map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>
" Rechtschreibprüfung <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=de_de,en_us<CR>
" Splits-Verhalten ändern: Teilt sich unten und rechts, was im Gegensatz zu vim Standardeinstellungen nicht verzögert ist.
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'

" vim-airline
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline_symbols.colnr = ' C:'
	let g:airline_symbols.linenr = ' L:'
	let g:airline_symbols.maxlinenr = '☰ '

" vim-airline-theme (molokai solarized powerlineish tomorrow papercolor)
	" let g:airline_theme='papercolor'
	" let g:airline_solarized_bg='dark'
	let g:airline_powerline_fonts = 1

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace ex mode with gq
	map Q gq

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck -x %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "%:p"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout "%:p"<CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex<CR>
	let g:vimwiki_list = [
	  \ {'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'},
	  \ {'path': '~/.local/share/nvim/sarbs', 'syntax': 'default', 'ext': '.wiki'},
	  \ {'path': '~/.local/share/nvim/YouTube', 'syntax': 'markdown', 'ext': '.md'},
	  \ {'path': '~/.local/share/nvim/Cyberwars', 'syntax': 'markdown', 'ext': '.md'},
	  \ {'path': '~/.local/share/nvim/Graphene', 'syntax': 'default', 'ext': '.wiki'},
	  \ {'path': '~/.local/share/nvim/Server', 'syntax': 'default', 'ext': '.wiki'},
	  \ ]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" 	let g:vimwiki_list = [{'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

" Save file as sudo on files that require root permission
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo 80 | call feedkeys("jk")
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo!\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo!\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e " add trailing newline for ANSI C standard
	autocmd BufWritePre *neomutt* %s/^--$/-- /e " dash-dash-space signature delimiter in emails
  	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>
" Load command shortcuts generated from bm-dirs and bm-files via shortcuts script.
" Here leader is ";".
" So ":vs ;cfz" will expand into ":vs /home/<user>/.config/zsh/.zshrc"
" if typed fast without the timeout.
silent! source ~/.config/nvim/shortcuts.vim
