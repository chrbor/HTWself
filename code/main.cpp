// SodokuSolver.cpp : Diese Datei enthält die Funktion "main". Hier beginnt und endet die Ausführung des Programms.
//

#include "pch.h"
#include <stdint.h>
#include <stdio.h>
#include <conio.h>
#include <windows.h>

#include "drawings.h"
#include "sodokuSolver.h"

void gotoxy(short x, short y) //cursor-positioner                                            
{
	COORD pos = { x,y };
	SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), pos);
}

COORD getxy() {
	CONSOLE_SCREEN_BUFFER_INFO screenBufferInfo;
	HANDLE hStd = GetStdHandle(STD_OUTPUT_HANDLE);
	if (!GetConsoleScreenBufferInfo(hStd, &screenBufferInfo))
		printf("GetConsoleScreenBufferInfo (%d)\n", GetLastError());
	return screenBufferInfo.dwCursorPosition;
}

COORD add(COORD x, COORD y) { return {x.X + y.X, x.Y + y.Y}; }
COORD move(COORD pos, short steps) { return { (pos.X + steps) % 9, pos.Y + (pos.X + steps) / 9 }; }

COORD getInput(COORD pos, char *input) 
{
	COORD dir = {0,0};
	uint8_t in;

	//positioniere cursor:
	pos.X = (pos.X+1) * 2 + 2 * (pos.X/3);
	pos.Y = 4 + pos.Y + (pos.Y / 3);
	gotoxy(pos.X, pos.Y);
		
	in = _getch();

	if (in == 224) {
		
		in = _getch();
		switch (in)
		{
		case 75: dir = { -1,0 }; break;//left
		case 72: dir = { 0,-1 }; break;//up
		case 77: dir = { 1,0 }; break;//right
		case 80: dir = { 0,1 }; break;//down
		}
		*input = '\x00';
	}
	else { *input = in; }
	return dir;
}

int main()
{
	//Erstelle Eingabefeld:
	system("CLS");//clear screen
	printf("Sodoku- Solver v0.1\n\n");

	printf("Bitte gebe die Werte des Sodokus ein:\n");
	drawFrame();

	//*
	//Eingabe der vorgegebenen Werte:
	char in;
	COORD pos;
	COORD pos_old;
	initSodoku();

	while (true)
	{
		pos = { 0,0 };
		//Eintragezyklus:
		do
		{
			pos = add(getInput(pos, &in), pos);
			if (in > 48 && in <= 57) { //Zahl eingegeben
				setSodoku(pos, emptyField | (in - 48));
				printf("%hhu", in-48);
				if (pos.X != 8 || pos.Y != 8) pos = move(pos, 1);
			}
			else if (in == 32 || in == 48) { _putch(' '); setSodoku(pos, emptyField); pos = move(pos, 1); }//Space oder 0
			else if (in == 8) { _putch(' '); setSodoku(pos, emptyField); continue; }//Backspace
			else if (in == 27 || in == 13) break;//Escape oder Enter -> Abbruch

			if (pos.X > 8) pos.X = 0;
			if (pos.X < 0) pos.X = 8;
			if (pos.Y > 8) pos.Y = 0;
			if (pos.Y < 0) pos.Y = 8;
		}while (true);

		//Abfrage, ob so korrekt:
		gotoxy(0, 16);
		if (in == 27) {
			printf("Programm abbrechen? (y/n)");
			in = _getch(); _putch(in);
			if (in == 'y' || in == 'Y') return 0;
		}
		else {
			printf("Eingabe korrekt? (y/n)");
			in = _getch();
			_putch(in);
			if (in == 'y' || in == 'Y') break;
		}

		gotoxy(0, 16);
		printf("                          ");
	}
	printf("\n\nStarte Auswertung...\n");
	
	int res = solveSodoku();

	//Lösung des Problems:
	switch (res)
	{
	case 1:	printf("Vorgang wurde abgebrochen!");	break;
	case 2:	printf("Es konnte keine eindeutige L\x94sung gefunden werden.\nWurde vielleicht eine Zahl vergessen?"); break;
	case 3:	printf("Widerspruch gefunden: Das Sodoku ist nicht l\x94sbar!\nWurde vielleicht eine Zahl falsch eingegeben?"); break;
	default:
		printf("L\x94sung ermittelt:\n");
		pos_old = getxy();
		drawFrame();
		//Fülle das Sodoku aus (Zeile 21):
		
		for (int x = 0; x < 9; x++) {
			for (int y = 0; y < 9; y++) {
				//positioniere cursor:
				pos.X = (x + 1) * 2 + 2 * (x / 3);
				pos.Y = 1 + y + (y / 3);
				gotoxy(pos.X + pos_old.X, pos.Y + pos_old.Y);

				printf("%hhu", getSodoku(x,y) & 0b1111);
			}
		}
		gotoxy(0, 13 + pos_old.Y);
		break;
	}

	getchar();
	//*/
}
