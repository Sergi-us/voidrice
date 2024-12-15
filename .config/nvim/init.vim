" ==========================================================================
" ====																	====
" ====					SARBS Neovim-Konfiguration						====
" ====					Letzte Änderung: 13.11.2024						====
" ====					https://sarbs.sergius.xyz						====
" ====																	====
" ====					TODO	umstieg auf lua							====
" ====					TODO	Gojo fixen								====
" ====					TODO	automatisierung testen					====
" ==========================================================================


" ===== Basis-Einstellungen =====
	let mapleader =","
	set encoding=utf-8
	set mouse=a						" Mausunterstützung in allen Modi
	set title						" Setzt den Fenstertitel
	set go=a						" Aktiviert alle GUI-Optionen
	filetype plugin on				" Aktiviert Dateityp-Plugins
	syntax on						" Aktiviert Syntax-Highlighting
	set clipboard+=unnamedplus		" System-Clipboard Integration
	set nohlsearch					" Deaktiviert Such-Highlighting
	set number relativenumber		" Relative + absolute Zeilennummern
	set wildmode=longest,list,full	" Verbesserte Befehlszeilen-Vervollständigung

" ===== zusätzliche Bindings in Normal-mode =====
	nnoremap YY ZZ
	nnoremap YQ ZQ
	nnoremap - /

" ===== Plugin Management =====
	" Automatische vim-plug Installation
	if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
		echo "Downloading junegunn/vim-plug to manage plugins..."
		silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
		silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
		autocmd VimEnter * PlugInstall
	endif

	" Plugin-Liste
	call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
		Plug 'tpope/vim-surround'				" Umgebende Zeichen bearbeiten
		Plug 'preservim/nerdtree'				" Dateiexplorer
		Plug 'junegunn/goyo.vim'				" Fokussierter Schreibmodus
		Plug 'jreybert/vimagit'					" Git Integration
		Plug 'vimwiki/vimwiki'					" Persönliches Wiki
		Plug 'vim-airline/vim-airline'			" Statusleiste
		Plug 'vim-airline/vim-airline-themes'	" Airline Themes
		Plug 'tpope/vim-commentary'				" Kommentarfunktionen
		Plug 'ap/vim-css-color'					" Farb-Previews
		Plug 'mechatroner/rainbow_csv'			" CSV-Datei Highlighting
	call plug#end()

" ===== Visuelle Einstellungen =====
	" Farbschema
	colorscheme vim
	set bg=dark

	" Cursor und Linien-Highlights
	set colorcolumn=80
	set cursorline
	set cursorcolumn
	highlight ColorColumn ctermbg=NONE guibg=NONE guifg=#FF0000 gui=underline cterm=underline
	highlight CursorLine ctermbg=234 guibg=#1c1c1c cterm=NONE gui=NONE
	highlight CursorColumn ctermbg=234 guibg=#1c1c1c cterm=NONE gui=NONE

	" Unsichtbare Zeichen
	set list
	set listchars=tab:›\ ,lead:·,trail:·,extends:→,precedes:←,nbsp:␣

" ===== Faltungseinstellungen =====
	set foldmethod=indent          " Faltung basierend auf Einrückung
	set foldnestmax=10            " Maximale Verschachtelungstiefe
	set foldenable                " Aktiviert Faltungen
	set foldminlines=2            " Minimale Zeilenanzahl für Faltung

	" Faltungshervorhebung
	highlight Folded guifg=#BBC2C9 guibg=#262B31 gui=NONE ctermbg=235 ctermfg=250 cterm=NONE
	highlight FoldColumn guifg=#9EA7B3 guibg=#2D333B gui=NONE ctermbg=236 ctermfg=248 cterm=NONE

" ===== Einrückungseinstellungen =====
	set tabstop=4                 " Tab = 4 Spaces
	set shiftwidth=4              " Einrücktiefe
	set softtabstop=4            " Backspace löscht 4 Spaces

" ===== Plugin-Konfigurationen =====
	" VimWiki
	let g:vimwiki_list = [
		\ {'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'},
		\ {'path': '~/.local/share/nvim/sarbs', 'syntax': 'default', 'ext': '.wiki',
			\ 'path_html': '~/www/sarbs',
			\ 'auto_toc': 1,
			\ 'auto_tags': 1,
			\ 'auto_generate_links': 1,
			\ 'auto_generate_tags': 1},
		\ {'path': '~/.local/share/nvim/YouTube', 'syntax': 'markdown', 'ext': '.md'},
		\ {'path': '~/.local/share/nvim/YouTube-wiki', 'syntax': 'default', 'ext': '.wiki'},
		\ {'path': '~/.local/share/nvim/SARBS', 'syntax': 'default', 'ext': '.wiki'},
		\ {'path': '~/.local/share/nvim/Graphene', 'syntax': 'default', 'ext': '.wiki'},
		\ {'path': '~/.local/share/nvim/Server', 'syntax': 'default', 'ext': '.wiki'},
		\ {'path': '~/.local/share/nvim/memes', 'syntax': 'default', 'ext': '.wiki'},
		\ {'path': '~/.local/share/nvim/Schaal', 'syntax': 'default', 'ext': '.wiki'},
		\ {'path': '~/.local/share/nvim/Windows', 'syntax': 'default', 'ext': '.wiki'},
		\ ]
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_text_ignore_newline = 0
	autocmd FileType vimwiki nnoremap <buffer> - /

	" NERDTree
	let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'

	" vim-airline
		" Aktiviere powerline Symbole und Nerd Fonts
		let g:airline_powerline_fonts = 1

		" Git Integration aktivieren
		let g:airline#extensions#branch#enabled = 1
		let g:airline#extensions#hunks#enabled = 1

"	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
"	endif
"	let g:airline_symbols.colnr = ' C:'
"	let g:airline_symbols.linenr = ' L:'
"	let g:airline_symbols.maxlinenr = '☰ '
"	let g:airline_powerline_fonts = 1

" ===== Tastenkombinationen =====
	" Platzhalter-Navigation
	map ,, :keepp /<++><CR>ca<
	imap ,, <esc>:keepp /<++><CR>ca<

	" Fenster-Navigation
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

	" Plugin-Shortcuts
	map <leader>n :NERDTreeToggle<CR>
	map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>
	map <leader>v :VimwikiIndex<CR>

	" Utility-Shortcuts
	map <leader>o :setlocal spell! spelllang=de_de,en_us<CR>
	map <leader>s :!clear && shellcheck -x %<CR>
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>
	map <leader>c :w! \| !compiler "%:p"<CR>
	map <leader>p :!opout "%:p"<CR>
	nnoremap S :%s//g<Left><Left>
	nnoremap c "_c                " Löschen ohne Register-Änderung

" ===== Splits und Fenster =====
set splitbelow splitright     " Natürlicheres Split-Verhalten

" ===== Dateityp-spezifische Einstellungen =====
	augroup FileTypeSpecific
		autocmd!
		" Python: 4 Spaces Einrückung
		autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
		" JavaScript: 2 Spaces Einrückung
		autocmd FileType javascript setlocal expandtab tabstop=2 shiftwidth=2
		" Markdown: Marker-basierte Faltung
		autocmd FileType markdown setlocal foldmethod=marker
	augroup END

	" Dateityp-Erkennung
		autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
		autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
		autocmd BufRead,BufNewFile *.tex set filetype=tex
		autocmd BufRead,BufNewFile *.h set filetype=c
		autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults

" ===== Automatische Aktionen =====
	" Cleanup beim Speichern
	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
	autocmd BufWritePre *neomutt* %s/^--$/-- /e
	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

	" Externe Programme
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

	" Externe Konfigurationen
	source ~/.config/nvim/plugin/voidrice.vim

" ===== Spezielle Einstellungen =====
	" Diff-Modus Highlighting
	if &diff
		highlight! link DiffText MatchParen
	endif

	" Goyo für mutt
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo 80 | call feedkeys("jk")
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo!\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo!\|q!<CR>

	" Statusleisten-Toggle Funktion
	let s:hidden_all = 0
	function! ToggleHiddenAll()
		if s:hidden_all == 0
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

	" Sudo-Save Befehl
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" ===== Shortcut Integration =====
	" Integration mit externem Shortcut-System
	" Verwendet ; als speziellen Marker (nicht mapleader)
	" Beispiel: ':vs ;cfz' expandiert zu ':vs /home/user/.config/zsh/.zshrc'
	silent! source ~/.config/nvim/shortcuts.vim

" zum ausführen in nvim :%call PrependIPs()
function! PrependIPs()
    let line = getline('.')
    let ips = []
    call substitute(line, '\v(\d{1,3}(\.\d{1,3}){3})', '\=add(ips, submatch(0))', 'g')
    if !empty(ips)
        call setline('.', join(ips, ' ') . ' ' . line)
    endif
endfunction

" zum ausführen in nvim :%call CountIPFrequencies()
:function! CountIPFrequencies()
    let ip_counts = {}
    for line in getline(1, '$')
        let matches = matchlist(line, '\v(\d{1,3}(\.\d{1,3}){3})')
        if !empty(matches)
            let ip = matches[1]
            if has_key(ip_counts, ip)
                let ip_counts[ip] += 1
            else
                let ip_counts[ip] = 1
            endif
        endif
    endfor
    call setline(1, [])
    for [ip, count] in sort(items(ip_counts), {a,b -> b[1] - a[1]})
        call append('$', printf('%5d %s', count, ip))
    endfor
endfunction
