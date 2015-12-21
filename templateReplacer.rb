#!/usr/bin/env ruby

if ARGV.length != 2
	puts "Sie haben #{ARGV.length} Parameter übergeben."

	puts "Mit diesem Skript ist es möglich, ein Template-Dokument (tdok) mit mehreren Variablen zu ersetzen. Die Werte, die eingesetzt werden, stehen in einem anderen Dokument (vardok)."
	puts "Die Variablen im tdok sind gekennzeichnet durch diese Schreibeweise (mit Leerzeichen!) : *** varname ***"
	puts "Im vardok sind die Werte durch ;;; voneinander getrennt. Zeilenumbrüche trennen die einzelnen Ersetzungsdokumente. In der ersten Zeile muss stehen, wie die einzelnen Variablen heißen, die ersetzt werden sollen. Zb so:"
	puts "holzname;;;blavariable;;;fertigvariable"
	puts "Dann wird im tdok, wo *** holzname *** steht, jeweils der Wert aus der ersten Spalte ersetzt."

	puts "Beispielaufruf: ./templateReplacer.rb /vollstaendiger/Pfad/tdok /vollst/Pfad/vardok"
	puts "Ergebnis ist '(Name tdok).replaced' im selben Verzeichnis, in dem die einzelnen Ersetzungen mit zwei Zeilenumbrüchen voneinander getrennt liegen."

	exit
end

tdok = ARGV[0]
if not File.exist?(tdok)
	puts "Die Datei #{tdok} existiert nicht!"
	exit
end

vardok = ARGV[1]
if not File.exist?(vardok)
	puts "Die Datei #{vardok} existiert nicht!"
	exit
end

varnames = Array.new
vars = Array.new

# Werte holen
begin
	readfile = File.new(vardok, "r")

	first_line = true

	while (line = readfile.gets)
		if first_line
			varnames = line.strip.split(";;;")
			first_line = false
			next
		end

		tmp = line.strip.split(";;;")
		vars << tmp
	end

	readfile.close
rescue => err
	puts "Exception: #{err}"
	err
end

dok = ""
tmpdok = ""

# Werte einsetzen
begin
	readfile = File.new(tdok, "r")
	while (line = readfile.gets)
		dok += line
	end
	readfile.close

	File.open("#{tdok}.replaced", 'w') do |writefile|
		vars.each_with_index do |v, index|
			tmpdok = String.new(dok)

			varnames.each_with_index do |name, index2|
				tmpdok.gsub!("*** #{name} ***", v[index2])
			end

			writefile.write(tmpdok + "\n\n")
		end
	end
rescue => err
	puts "Exception: #{err}"
	err
end