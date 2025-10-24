#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int TRUE = 1;
static int FALSE = 0;

static char *FLAG_HELP 		= "--help";
static char *FLAG_ZEN 		= "--zen";
static char *FLAG_VERSION 	= "--version";

void echo(char val[]) { printf("%s\n", val); }

// TODO: Documentation
char **split(char *string, char delimiter) {
  char **res = (char **)malloc(strlen(string) + 1);
  char *buffer = (char *)malloc(strlen(string) + 1);
  int b = 0;
  int count = 0;

  for (int i = 0; i < strlen(string); i++) {
    if (string[i] == delimiter) {
      res[count] = buffer;
      buffer = (char *)malloc(strlen(string));
      b = 0;
      count++;
      continue;
    } else {
      buffer[b] = string[i];
      b++;
    }
  }

  if (strlen(buffer) > 0) {
    res[count] = buffer;
    buffer = (char *)malloc(strlen(string));
  }
  return res;
}

// TODO: Documentation
int *split_range(char *range) {
  static int x[2];

  char **res = split(range, ':');

  if (res[0] != NULL) {
    x[0] = atoi(res[0]);
  }

  if (res[1] != NULL) {
    x[1] = atoi(res[1]);
  }

  return x;
}

int has_char(char haystack[], char needle) {
  for (int i = 0; i < strlen(haystack); i++) {
    if (haystack[i] == needle) {
      return 1;
    }
  }

  return 0;
}

// TODO: Not too sure about this algorithm/impementation but it seems to be
// working on majority test cases; Revisit.
int contains(char *string, char *sub_string) {
  int i = 0;
  int j = 0;

  int contiguous_count = 0;

  while (i < strlen(string)) {
    if (string[i] == sub_string[j]) {
      contiguous_count++;
      j++;
    } else {
      if (contiguous_count >= strlen(sub_string)) {
        return TRUE;
      }
      contiguous_count = 0;
      j = 0;
    }

    i++;
  }

  return (contiguous_count == strlen(sub_string));
}

int is_flag(char *string) { return contains(string, "--"); }

void handle_flag(char *flag) {
  // TODO: I'd much rather avoid using strcmp here, are there any alternatives?
  // 	-> See - https://cplusplus.com/reference/cstring/strcmp/
  if (strcmp(flag, FLAG_HELP) == 0) {
    echo("contra [file | arguments]");
    echo("---------");
    echo("Examples:");
    echo("---------");
    echo("contra file.txt\t\t reads file");
    echo("contra file.txt:40\t reads line 40 only");
    echo("contra file.txt 40\t reads line 40 only");
    echo("contra file.txt:40:50\t reads lines 40 to 50 of the file");
    echo("contra file.txt 40:50\t reads lines 40 to 50 of the file");
    echo("---------");
    echo("Arguments:");
    echo("---------");
    echo("--help\t shows help/manual");
    echo("--zen\t shows zen");
  } else if (strcmp(flag, FLAG_ZEN) == 0) {
    echo("And he who is not a bird should not camp above abysses.");
	} else if (strcmp(flag, FLAG_VERSION) == 0) {
		echo("v0.0.1");
	}
}
