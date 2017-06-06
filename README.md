# TemplateReplacer

Usage: ./templateReplacer.rb /full/path/tdok

With this script it is possible to replace a template document (tdok) with several variables. The values that are inserted should be contained in another document (vardok). The path to the vardok should be in the first line of tdok.
This script can be helpful for creating large files where you would like to insert a structure several times in which only small changes should be made. Like creating a table in HTML. You can also create several files.

## tdok
The variables in tdok are denoted by this syntax (including the spaces inside!): *** variablename ***

## vardok
The values in vardok are separated by ;;;
Line breaks separate the different values that will be filled in. With each line, a new copy of the tdok will be inserted below in the resulting file (separated with two line breaks).
It is necessary to specify the variable names in the first line. Example:

	variableA;;;variableB;;;variableC
	text1;;;text2;;;text3

*** variableA *** will be replaced by "text1" at all the occurences of variableA in tdok etc.

## Example
	./templateReplacer.rb /full/path/tdok

	# or if templateReplacer.rb is in the same directory
	./templateReplacer.rb tdok

	see the example directory

## Result
The result will be '(name of tdok).replaced' in the same directory. The different replacements are separated by two line breaks in this file.

If the first column in vardok has the name FILENAME, templateReplacer will create a new file for each line in vardok (instead of separating the replacements by line breaks).


## Notes
It is possible to nest replacements. They are performed from left to right in vardok. See example directory.

