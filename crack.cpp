#include "TXLib.h"
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <windows.h>
#include <playsoundapi.h>

static const char*  PROG_NAME         = "vzlom.COM";
static const char*  CRACKED_PROG_NAME = "crack.com";
static const size_t JMP_CODE          = 235;

static const char*  MUSIC_NAME        = "data/8bit.wav";
static const char*  IMAGE_NAME        = "data/image.bmp";
static const size_t WINDOW_X          = 730;
static const size_t WINDOW_Y          = 450;

void crack(FILE *const prog, FILE *const cracked_prog);

int main()
{
    FILE* prog = fopen(PROG_NAME, "rb");
    if (!prog)
    {
        printf("can't open %s\n", PROG_NAME);
        return 1;
    }

    FILE* cracked_prog = fopen(CRACKED_PROG_NAME, "wb");
    if (!cracked_prog)
    {
        printf("can't open %s\n", CRACKED_PROG_NAME);
        return 1;
    }

    crack(prog, cracked_prog);

    fclose(prog);
    fclose(cracked_prog);

    txCreateWindow (WINDOW_X, WINDOW_Y);

    HDC image = txLoadImage (IMAGE_NAME);
    if (!image)     
    {
        txMessageBox ("error");
        return 1;
    }
    
    txBitBlt (txDC(), 0, 0, WINDOW_X, WINDOW_Y, image);

    PlaySound(MUSIC_NAME, NULL, SND_LOOP | SND_ASYNC);
    int stop_mark = 0;
    scanf("%d", &stop_mark);
    if (stop_mark == 1)
        PlaySound(NULL, NULL, 0); 

    txDeleteDC(image);

    return 0;
}

void crack(FILE *const prog, FILE *const cracked_prog)
{
    assert(prog);
    assert(cracked_prog);

    int the_byte = 0;

    for (size_t byte_cnt = 0; byte_cnt < 36; byte_cnt++)
    {
        the_byte = fgetc(prog);
        fputc(the_byte, cracked_prog);
    }

    fgetc(prog);
    fputc(JMP_CODE, cracked_prog);

    while (the_byte != EOF)
    {
        the_byte = fgetc(prog);
        fputc(the_byte, cracked_prog);
    }

    fputc(the_byte, cracked_prog);
}