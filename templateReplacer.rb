#!/usr/bin/env ruby

if ARGV.length != 2
	File.open("README.md", "r") do |infile|
	    while (line = infile.gets)
	        puts "#{line}"
	    end
	end

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

		unless line.strip.empty?
			tmp = line.strip.gsub("\\n", "\n").split(";;;")
			vars << tmp
		end
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
				tmpdok.gsub!("*** #{name} ***", v[index2] ? v[index2] : "")
			end

			writefile.write(tmpdok + "\n\n")
		end
	end
rescue => err
	puts "Exception: #{err}"
	err
end