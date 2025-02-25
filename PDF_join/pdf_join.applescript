-- Obtains the PDF files from Finder
tell application "Finder"
	set selectedItems to selection
	set pdfFiles to {}
	repeat with anItem in selectedItems
		if name extension of anItem is "pdf" then
			set end of pdfFiles to POSIX path of (anItem as alias)
		end if
	end repeat
	if pdfFiles = {} then
		display dialog "No PDF file selected." buttons {"OK"} default button "OK"
		return
	end if
	-- Uses the folder of the first file 
	set outputFolder to container of (item 1 of selectedItems)
	set outputPath to POSIX path of (outputFolder as alias) & "Combined.pdf"
end tell

-- Concat the list of files
set inputFiles to ""
repeat with filePath in pdfFiles
	set inputFiles to inputFiles & quoted form of filePath & " "
end repeat

-- Run the command to concat the files
do shell script "/opt/homebrew/bin/pdfunite " & inputFiles & quoted form of outputPath

display dialog "PDF combined and created on:" & return & outputPath buttons {"OK"} default button "OK"
