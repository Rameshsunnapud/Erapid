d:
cd \erapid\shared
erase /q *.rtf
erase /q *.pdf
cd email
for /d %%x in ("d:\erapid\shared\email\*") do rmdir /q /s "%%x"
