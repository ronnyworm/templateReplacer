#!/usr/bin/env ruby

if ARGV.length != 1
	File.open("README.md", "r") do |infile|
	    while (line = infile.gets)
	        puts "#{line}"
	    end
	end

	exit
end

tdok = ARGV[0]
if not File.exist?(tdok)
	puts "The file #{tdok} does not exist in #{Dir.pwd}..."
	exit
end

# read path to vardok
readfile = File.new(tdok, "r")
vardok = readfile.gets.chomp
readfile.close

if not File.exist?(vardok)
	puts "The file #{vardok} does not exist in #{Dir.pwd}... Check the first line of tdok (#{tdok})."
	exit
end

varnames = Array.new
vars = Array.new

mode = "replacements in one file below each other"

# Werte holen
begin
	readfile = File.new(vardok, "r")

	first_line = true

	while (line = readfile.gets)
		if first_line
			varnames = line.strip.split(";;;")

			if varnames[0] == "FILENAME"
				mode = "replacements in new file always"
			end

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
	first = true
	while (line = readfile.gets)
		if first
			# there is just the filename of vardok in this first line
			first = false
		else
			dok += line
		end
	end
	readfile.close

	if mode == "replacements in one file below each other"
		File.open("#{tdok}.replaced", 'w') do |writefile|
			vars.each_with_index do |v, index|
				tmpdok = String.new(dok)

				varnames.each_with_index do |name, index2|
					tmpdok.gsub!("*** #{name} ***", v[index2] ? v[index2] : "")
				end

				writefile.write(tmpdok + "\n\n")
			end
		end
	elsif mode == "replacements in new file always"
		vars.each_with_index do |v, index|
			File.open(v[0], 'w') do |writefile|
				tmpdok = String.new(dok)

				# skip first element (it's the FILENAME) - that's why we have to add 1 as well
				varnames[1..varnames.size].each_with_index do |name, index2|
					tmpdok.gsub!("*** #{name} ***", v[index2 + 1] ? v[index2 + 1] : "")
				end

				writefile.write(tmpdok)
			end
		end
	else
		puts "unknown mode ... exit"
	end
rescue => err
	puts "Exception: #{err}"
	err
end