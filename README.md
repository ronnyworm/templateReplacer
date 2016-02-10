# TemplateReplacer

With this script it is possible to replace a template document (tdok) with several variables. The values that are inserted should be contained in another document (vardok).
This can be helpful for creating large files where you would like to insert a structure several times in which only small changes should be made. Like creating a table in HTML. The structure in this example would be a row.

## tdok
The variables in tdok are denoted by this syntax (including the spaces inside!): *** variablename ***

## vardok
The values in vardok are separated by ;;;
Line breaks separate the different documents in which the replacements will be performed. (Im vardok sind die Werte durch ;;; voneinander getrennt. Zeilenumbrüche trennen die einzelnen Ersetzungsdokumente.)
It is necessary to specify the variable names in the first line. Example:

	variableA;;;variableB;;;variableC

When this is done correctly, *** variableA *** will be replaced by the values in the first column at all the occurences of variableA in tdok.

## Example
	./templateReplacer.rb /full/path/tdok /full/path/vardok

	# or if templateReplacer.rb is in the same directory
	./templateReplacer.rb tdok vardok

## Result
The result will be '(name of tdok).replaced' in the same directory. The different replacements are separated by two line breaks in this file.


## Notes
It is possible to nest replacements. They are performed from left to right in vardok.

