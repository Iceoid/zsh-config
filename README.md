# For Linux and WSL (windows terminal):

### Install zsh
`sudo apt update` < \br>
`sudo apt install curl zsh -y`

### Install oh-my-zsh
`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### Install powerlevel10k theme
`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`

### Change the theme in ~/.zshrc (ZSH_THEME="powerlevel10k/powerlevel10k)
`sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k/powerlevel10k"/' ~/.zshrc`

### Add your aliases (optional)
`echo 'alias ll="ls -hal"' >> ~/.zshrc`

### Install powerline mono fonts. Official ones (MesloLGS NF) are here
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

##### For Linux:
tbd

##### For Windows wsl:
##### To install, go to the Windows fonts menu and drag and drop the ttf files.

### (optional) For Visual Studio Code: 
Open File → Preferences → Settings, enter terminal.integrated.fontFamily in the search box and set the value to MesloLGS NF.

### Set the fontFace in the terminal options:
```
{
    "guid": "{YOUR-WSL-GUID}",
    "hidden": false,
    "name": "Ubuntu-20.04",
    "source": "Windows.Terminal.Wsl",
    "fontFace":"MesloLGS NF"
    
}
```
### Quit the terminal session and relaunch

### Run the configurator
`p10k configurator`

### Add option for transient prompt (same-dir)
`echo "typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir" >> ~/.p10k.zsh`

### Install plugins
#### syntax-highlighting
`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

#### autosuggestions
`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

#### In ~/.zshrc add the plugins in `plugins=()`
`plugins=( git zsh-syntax-highlighting zsh-autosuggestions )`

### after saving the file:
`source ~/.zshrc`


-----------------------------------------------------------------------------------------------------------------------
# For MacOS (iTerm2 is suggested)

### Install oh-my-zsh
`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### Install powerlevel10k theme
`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`

### Add your aliases (optional)
`echo 'alias ll="ls -hal"' >> ~/.zshrc`

### Install Fonts. iTerm2 can install them for you in the next step.
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf