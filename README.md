# md2html

## Usage

```bash
./md2html.sh example/report.md
```

then open `example/report.html` with browser

## Live Demo

- [input](https://yech1990.github.io/md2html/report.txt)
- [output](https://yech1990.github.io/md2html/report.html)

## Install

- install pandoc

  ```bash
  sudo pacman -S pandoc
  ```

- install dot2text dependence

  ```bash
  sudo pacman -S dot2tex
  ```

- install mermaid.cli dependence

  ```bash
  yarn add @mermaid-js/mermaid-cli
  # yarn install
  ./node_modules/.bin/mmdc -h
  ```
