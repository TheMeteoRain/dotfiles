# mise tools

## Install mise

```sh
curl https://mise.run | sh
```

## Install the tools

```sh
mise install
```

## Install other tools

https://github.com/ajeetdsouza/zoxide
```sh
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

grep -qxF 'eval "$(zoxide init bash)"' ~/.bashrc || \
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
```

https://github.com/junegunn/fzf
```sh
grep -qxF 'eval "$(fzf --bash)"' ~/.bashrc || \
echo 'eval "$(fzf --bash)"' >> ~/.bashrc
ln -sf "$(mise which fzf)" ~/.local/bin/fzf
```

```sh
ln -sf "$(mise which fzf)" ~/.local/bin/fzf
ln -sf "$(mise which fd)" ~/.local/bin/fd
```



Re-run after any `mise upgrade`.
