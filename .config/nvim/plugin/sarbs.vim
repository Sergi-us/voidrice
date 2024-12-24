" Funktion zum Konvertieren der Wiki zu CSV
function! Wiki2CSV()
	" Pfade definieren
	let wiki_file = '/home/sergi/.local/share/nvim/SARBS/progs.csv.wiki'
	let csv_file = '/home/sergi/.local/src/SARBS/progs.csv'

	" Wiki-Datei einlesen
	let lines = readfile(wiki_file)
	let csv_lines = []

	" Zeitstempel hinzufügen
	call add(csv_lines, '#,SARBS-Tools,' . strftime('"%Y-%m-%d %H:%M:%S"'))

	" Zeilen verarbeiten
	for line in lines
		if line =~ '^|' && line !~ '^|---' && line !~ '^| t' && line !~ '^| TAG'
			" Entferne alle | und trimme Leerzeichen zwischen den Feldern
			let cleaned = substitute(line, '\s*|\s*', '', 'g')
			" Trimme zusätzliche Leerzeichen am Anfang und Ende
			let cleaned = substitute(cleaned, '^\s*\(.\{-}\)\s*$', '\1', '')
			call add(csv_lines, cleaned)
		endif
	endfor

	" In CSV-Datei schreiben
	call writefile(csv_lines, csv_file)
	echo "Datei wurde erstellt: " . csv_file
endfunction

" Definiere den Befehl für den Aufruf
command! Sarbs2CSV call Wiki2CSV()
