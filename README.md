# SADVE

Extract value of C defines directly from command line

## Installation

```shell
git clone https://github.com/v3l0c1r4pt0r/sadve.git
cd sadve
mkdir -p build && cd build
cmake ..
make
sudo make install
```

## Usage

To get value of define AF\_INET, defined in header sys/socket.h, one can call:
```shell
sadve -d AF_INET sys/socket.h
```

Then to learn size of structure sockaddr as defined in sys/socket.h, use:
```shell
sadve -s sockaddr sys/socket.h
```

Full help text:
```
Usage: /usr/local/bin/sadve [--dec|--hex|--type=T] -d|-s|-u|-t|-e SYMBOL HEADER | -h
        -d, --define  Print final value of preprocessor macro
        -s, --struct  Print total length of struct
        -u, --union   Print total length of union
        -t, --type    Print total length of type
        -e, --enum    Print total length of enum
            --dec     Print value in decimal form (default)
            --hex     Print value in hexadecimal form
            --type=T  Print value in T form, where T is format string as in
                      printf(3)
        -h, --help    Print this help message and exit
        SYMBOL        Symbol which value is to be examined
        HEADER        Header where symbol is defined

```

## License

The program is licensed under GNU GPL v3.
