# osc52b

Show url and past with OSC52.

Alternative browser display for ssh connections. (or devcontainers)

## Usage

```
$ zig build -Drelease-small
$ cp ./zig-out/bin/osc52b ~/.local/bin/x-www-browser
$ env -i PATH=$PATH xdg-open http://example.com/
🌏 http://example.com/
$ # `http://example.com/` will have been copied to the clipboard.
$ # or
$ BROWSER=~/.local/bin/x-www-browser gh repo view -w
🌏 https://github.com/yskszk63/osc52b
$
```

## Terminals

| Terminal                         |        |
|----------------------------------|--------|
| Alacritty                        | OK     |
| WezTerm                          | OK     |
| Nvim_terminal_emulator           | NOT OK |
| Nvim_terminal_emulator (via SSH) | OK     |

## Author

[yskszk63](https://github.com/yskszk63)

## License

[MIT](LICENSE)
