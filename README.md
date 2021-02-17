## lbase64

Louise Dev Team Base64 for macOS & linux.

## Usage

```bash
Usage:    lbase64 [options] <input text>
  -h, --help     display this message
  -d, --decode   decodes input
  -e, --encode   encodes input

  e.g.    lbase64 -e "Hello Louise"
will gets: SGVsbG8gTG91aXNl
```

## Build

```bash
swiftc main.swift Base64.swift -O -o lbase64
```

## License

lbase64 is available under the MIT license.

