<!-- INTRO -->

<!-- Title -->
<div align="center">

# ~ akai's dotfiles! ~
minimal rice based on the game [Milk outside a bag of milk outside a bag of milk](https://store.steampowered.com/app/1604000/Milk_outside_a_bag_of_milk_outside_a_bag_of_milk)

<!-- Desktop preview -->
![](https://raw.githubusercontent.com/akai-hana/assets/main/o-frag-160.gif)

<!-- Badges -->
![Chimera Linux](https://img.shields.io/badge/OS-Chimera_Linux-magenta)
![Maintained](https://img.shields.io/badge/Maintained-Yes-green)

</div>

<!-- BODY -->

---

## preview

> *Soon™*
> <!-- TODO: place video link here -->

---

## installation

### <img src="https://raw.githubusercontent.com/akai-hana/assets/main/GitHub.svg" width="25" height="25"> cloning
```sh
git clone https://github.com/akai-hana/dotfiles
```

<!-- Not specifying height in the icon makes it so that it preserves the exact original image ratio -->
### <img src="https://raw.githubusercontent.com/akai-hana/assets/main/GNU_stow.png" width="25"> stowing (with `xstow`)

you can easily stow and unstow these dotfiles onto your system with the provided `Makefile`.

> these dotfiles only officially support `xstow`.
> 
> any pull requests that add compatibility with other tools are always welcome. :)

before installing, i recommend testing whether everything will work correctly: 
```sh
# with root permission privileges, or logged in as a root user:
make test
```

if there's no complaints, you can proceed to install without any worries:
```sh
# with root permission privileges, or logged in as a root user:
make install
```

> [this](https://github.com/akai-hana/dotfiles/blob/main/Makefile) `Makefile` is fully UNIX-compliant, with the objective to be as cross-compatible as possible.
>
> as a result, it supports both GNU's and BSD's make implementations, `gmake` and `bmake`, supporting both operative systems, and potentially any other UNIX-based OS.

---

## specs

#### system

+ **OS/distro:** [Chimera Linux](https://chimera-linux.org/)
+ **window manager:** dwm [(my custom build)](https://github.com/akai-hana/suckless/)
+ **wallpaper:** upon boot, a randomly picked shader from [here](https://github.com/akai-hana/shader-wallpaper/tree/main/shadow/), using [this project](https://github.com/danielfvm/shadow/) along with the help of my [script utilities](https://github.com/akai-hana/shader-wallpaper/tree/main/shadow/scripts/)
---

#### tools

+ **terminal:** ghostty
+ **shell:** fish
+ **font:** firacode *(with nerdfonts and ligatures)*
+ **text editor:** vim for config editing.
> *TODO: learn emacs and elisp, configure emacs as an IDE*
+ **file explorer:** yazi
> *TODO: learn broot; seems like a more powerful tool, but will require learning*

#### media

+ **browser:** firefox *(previously zen, but switched due to performance issues. sidebery is already half of what i liked out of zen)*
+ **discord client:** [equibop](https://equibop.org/) *(fork of [Vesktop](https://vesktop.dev/) (fork of [Vencord](https://vencord.dev/) (fork of... discord.)))*
+ **video/audio player:** mpv
+ **youtube client:** [freetube](https://freetubeapp.io/)
+ **music:** youtube music *(specifically the client [Pear Desktop](https://github.com/pear-devs/pear-desktop/))*
+ **torrent client:** deluge

---

## 📋 TODO

- [ ] video demonstration
- [ ] keybindings documentation
- [ ] finish installation documentation
- [ ] write about goals of these dotfiles
- [ ] link to my other repos
- [ ] mention eudaimonia in documentation
- [ ] mv -n alias

---

<div align="center">

made with ❤️ by akai

</div>
