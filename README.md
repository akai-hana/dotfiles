<!-- INTRO -->

<!-- Title -->
<div align="center">
<h1>~ akai's dotfiles! ~</h1>
</div>

<!-- Subtitle -->
<div align="center">
  <p>
    <i>A minimal, aesthetic rice featuring dwm, shader wallpapers, and carefully curated tools for a productive workflow.</i>
  </p>
</div>

<!-- Desktop preview -->
![](https://raw.githubusercontent.com/akai-hana/assets/main/o-frag-160.gif)

<!-- Badges -->
![Chimera Linux](https://img.shields.io/badge/Distro-Chimera_Linux-magenta)
![Maintained](https://img.shields.io/badge/Maintained-Yes-green)

<!-- BODY -->

***

## 📸 Preview
<p>
  <blockquote>
    <i>Soon™</i>
  </blockquote>
</p>

***

## 🚀 Quick Start

### <img src="https://raw.githubusercontent.com/akai-hana/assets/main/GitHub.svg" width="40" height="40"> Cloning
```sh
git clone https://github.com/akai-hana/dotfiles
```


### <img src="https://raw.githubusercontent.com/akai-hana/assets/main/GNU_stow.png" width="40" height="40"> Stowing (with xstow)
You can easily stow and unstow these dotfiles onto your system with the provided Makefile.

> These dotfiles only officially support xstow.
> 
> Any pull requests that add compatibility with other tools are always welcome. :)

Before installing, I firstly recommend testing whether everything will work correctly: 
```sh
# With root permissions,
make test
```

If there's no complaints, you can proceed to install without any worries:
```sh
# With root permissions,
make install
```

> This Makefile supports both `gmake` and `bmake`. This means it supports both Linux and *BSD.
>
> Feel free to use the tool that's more convenient to you. :)

***

## ⚙️ System
+ **window manager:** dwm [(my custom build)](https://github.com/akai-hana/suckless)
+ **distro:** [Chimera Linux](https://chimera-linux.org)

***

<details>

  <summary><b>🔧 Full Software Stack</b></summary>

### 🛠️ Apps/Tools

#### Development
+ **terminal:** ghostty
+ **shell:** fish
+ **font:** firacode + nerdfonts + ligatures *(monospaced for code and proportional for UI's)*
+ **text editor:** vim for config editing and DOOM emacs as a working IDE
+ **file explorer:** yazi *(to browse files)* and broot *(if i want to execute specific files, like videos or audios)*

#### Media
+ **video/audio player:** mpv
+ **browser:** firefox (with sidebery and custom css, better performance than zen)
+ **discord client:** equibop
+ **music:** youtube music (th-ch's wrapper)
+ **torrent client:** deluge

#### Aesthetics
+ **wallpaper:** upon boot, a randomly picked shader from [here](https://github.com/akai-hana/shader-wallpaper/tree/main/shadow), using [this project](https://github.com/danielfvm/shadow)
> For more info on wallpaper setup, check [this little guide](https://github.com/akai-hana/shader-wallpaper/blob/main/README.md).

</details>

***

## 📋 TODO
- [ ] Video demonstration
- [ ] Keybindings documentation
- [ ] Finish installation documentation
- [ ] Write about goals of these dotfiles
- [ ] Link to my other repos
- [ ] Mention eudaimonia in documentation

***

<div align="center">
  Made with ❤️
</div>
