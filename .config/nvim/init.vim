let mapleader =","
" SARBS 27.10.2024
" TODO das 'q' dilemma Überdenken...

" Plugins herunterladen und verwalten mit vim-plug
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

map ,, :keepp /<++><CR>ca<
imap ,, <esc>:keepp /<++><CR>ca<

" Plugins-Liste
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

" voreingestelltes Farbschema
	colorscheme vim

" Faltungseinstellungen
	set foldmethod=indent       " Faltung basierend auf Einrückung
	set foldnestmax=10          " Maximale Verschachtelungstiefe
	" set foldenable            " Startet mit gefalteten Bereichen
	set nofoldenable            " Startet mit allen offenen Faltungen
	set foldminlines=2          " Minimale Zeilenanzahl für eine Faltung

" Faltungshervorhebung
    highlight Folded guifg=#BBC2C9 guibg=#262B31 gui=NONE ctermbg=235 ctermfg=250 cterm=NONE
    " highlight Folded guifg=#D3D7DB guibg=#1F242A gui=NONE ctermbg=234 ctermfg=252 cterm=NONE
    highlight FoldColumn guifg=#9EA7B3 guibg=#2D333B gui=NONE ctermbg=236 ctermfg=248 cterm=NONE

" Einrückungseinstellungen
    set expandtab			" Konvertiert Tab zu Spaces
    set tabstop=4			" Tab entspricht 4 Leerzeichen
    set shiftwidth=4        " Einrücktiefe für automatische Einrückung
    set softtabstop=4       " Backspace löscht 4 Spaces als wäre es ein Tab
    " set foldlevel=1		" Öffnet Faltungen bis Level 1
    " set foldlevel=2		" Faltungen bis Level 2 standardmäßig öffnen
    " :set foldmethod=indent	" Probier dies in einer Python-Datei
    " :set foldmethod=syntax	" Dann dies in einer Java/C++ Datei
    " :set foldmethod=marker	" Und dies in einer Dokumentation

" Visuelle Hilfen
    set list                     " Aktiviert die Anzeige von unsichtbaren Zeichen
    " set listchars=tab:│\ ,lead:·   " │⇥↹ für Tabs, · für Leerzeichen am Zeilenanfang
    set listchars=tab:│\ ,lead:·,trail:·,extends:→,precedes:←,nbsp:␣

" Dateityp-spezifische Einstellungen
augroup FileTypeSpecific
    autocmd!
    " Python: 4 Spaces Einrückung
    autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
    " JavaScript: 2 Spaces Einrückung
    autocmd FileType javascript setlocal expandtab tabstop=2 shiftwidth=2
    " Markdown: Marker-basierte Faltung
    autocmd FileType markdown setlocal foldmethod=marker
augroup END

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
	" colorscheme desert	" kontrastreiche Farbschema (transprenz verschwindet)

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

" Führe Befehle über visuelle Blöcke aus
	vnoremap . :normal .<CR>

" Goyo-Plugin für bessere Lesbarkeit beim Schreiben:
	map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>

" Rechtschreibprüfung <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=de_de,en_us<CR>

" Splits-Verhalten ändern: Teilt sich unten und rechts, was im Gegensatz zu vim Standardeinstellungen nicht verzögert ist.
	set splitbelow splitright

" Hervorhebungen für Zeilenende und Zeile und Spalte
" TODO Transparenz für die Herforhebung von Zeilen und Spalten einrichten...
    set colorcolumn=80
    highlight ColorColumn ctermbg=NONE guibg=NONE guifg=#FF0000 gui=underline cterm=underline
    set cursorline          " Hebt die aktuelle Zeile hervor
    " highlight CursorLine   ctermbg=NONE guibg=NONE cterm=underline gui=underline
    highlight CursorLine   ctermbg=234 guibg=#1c1c1c cterm=NONE gui=NONE
    set cursorcolumn        " Hebt die aktuelle Spalte hervor
    " highlight CursorColumn ctermbg=NONE guibg=NONE cterm=underline gui=underline guifg=#303030
    highlight CursorColumn ctermbg=234 guibg=#1c1c1c cterm=NONE gui=NONE

" NERDTree Konfiguration
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

" Fensternavigation verkürzen, spart einen Tastendruck
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Ex-Modus durch gq ersetzen
	map Q gq

" Datei mit shellcheck überprüfen
	map <leader>s :!clear && shellcheck -x %<CR>

" Bibliographie-Datei im geteilten Fenster öffnen
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" 'Alles ersetzen' wird auf S zugewiesen
	nnoremap S :%s//g<Left><Left>

" Dokument kompilieren (für groff/LaTeX/markdown/etc.)
	map <leader>c :w! \| !compiler "%:p"<CR>

" Zugehörige .pdf/.html öffnen oder Vorschau anzeigen
	map <leader>p :!opout "%:p"<CR>

" Entfernt tex-Build-Dateien beim Schließen einer .tex Datei
	autocmd VimLeave *.tex !texclear %

" VimWiki Konfiguration - Syntax und Dateierweiterungen
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Aktiviert automatische Zeilenumbrüche bei der HTML-Konvertierung
    let g:vimwiki_text_ignore_newline = 0

" Tastenkombination für VimwikiIndex
	map <leader>v :VimwikiIndex<CR>

" Liste der VimWiki-Verzeichnisse mit entsprechenden Einstellungen
	let g:vimwiki_list = [
	  \ {'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'},
	  \ {'path': '~/.local/share/nvim/sarbs', 'syntax': 'default', 'ext': '.wiki',
        \ 'path_html': '~/www/sarbs',
        \ 'auto_toc': 1,
        \ 'auto_tags': 1,
        \ 'auto_generate_links': 1,
        \ 'auto_generate_tags': 1},
	  \ {'path': '~/.local/share/nvim/YouTube', 'syntax': 'markdown', 'ext': '.md'},
	  \ {'path': '~/.local/share/nvim/Cyberwars', 'syntax': 'markdown', 'ext': '.md'},
	  \ {'path': '~/.local/share/nvim/Graphene', 'syntax': 'default', 'ext': '.wiki'},
	  \ {'path': '~/.local/share/nvim/Server', 'syntax': 'default', 'ext': '.wiki'},
	  \ {'path': '~/.local/share/nvim/memes', 'syntax': 'default', 'ext': '.wiki'},
	  \ {'path': '~/.local/share/nvim/Schaal', 'syntax': 'default', 'ext': '.wiki'},
	  \ ]

" Dateitypen korrekt erkennen
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	autocmd BufRead,BufNewFile *.h set filetype=c

"	let g:vimwiki_list = [{'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

" Datei mit sudo-Rechten speichern
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Goyo standardmäßig für mutt aktivieren
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo 80 | call feedkeys("jk")
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo!\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo!\|q!<CR>

" Automatisch alle nachfolgenden Leerzeichen und Leerzeilen am Dateiende beim Speichern löschen
" & Cursorposition zurücksetzen
	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
" Fügt Zeilenumbruch am Ende für ANSI C Standard hinzu
	autocmd BufWritePre *.[ch] %s/\%$/\r/e " add trailing newline for ANSI C standard
" Signatur-Trennzeichen in E-Mails
    autocmd BufWritePre *neomutt* %s/^--$/-- /e " dash-dash-space signature delimiter in emails
	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" Bei Aktualisierung der Verknüpfungsdateien bash und ranger Konfigurationen erneuern
	autocmd BufWritePost bm-files,bm-dirs !shortcuts

" xrdb bei Aktualisierung von Xdefaults oder Xresources ausführen
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %

" dwmblocks bei Konfigurationsänderung neu kompilieren
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Deaktiviert die Hervorhebung der geänderten Codeteile, sodass die geänderte
" Zeile hervorgehoben wird, aber der tatsächlich geänderte Text auf der Zeile
" hervorsticht und lesbar ist
if &diff
    highlight! link DiffText MatchParen
endif

" Funktion zum Umschalten der unteren Statusleiste
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

" Lade Befehlsverknüpfungen, die von bm-dirs und bm-files über das shortcuts-Skript generiert wurden.
" Hier ist leader ";"
" Also wird ":vs ;cfz" zu ":vs /home/<user>/.config/zsh/.zshrc" erweitert,
" wenn es schnell ohne Zeitüberschreitung eingegeben wird.
silent! source ~/.config/nvim/shortcuts.vim
