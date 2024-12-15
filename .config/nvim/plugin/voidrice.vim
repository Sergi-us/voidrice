" Dateien die automatisch in mein Github verzeichniss kopiert werden
autocmd BufWritePost ~/.config/nvim/init.vim silent !cp % ~/Sergi-us/voidrice/.config/nvim/%:t
autocmd BufWritePost ~/.config/nvim/plugin/sarbs.vim silent !cp % ~/Sergi-us/voidrice/.config/nvim/plugin/%:t
autocmd BufWritePost ~/.config/nvim/plugin/voidrice.vim silent !cp % ~/Sergi-us/voidrice/.config/nvim/plugin/%:t
" ende
" ende
