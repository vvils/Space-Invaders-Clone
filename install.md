# Otune Platform

This project seeks to build an audio player application and draws much of its naming inspiration from Apple Inc’s iTunes and much of its graphics and functionality from Spotify. The user interface will contain a search bar for which a user may search any song they like and it will play on the application. The song search will return what Spotify would return. The application will also allow users to queue, skip, pause/play, and adjust the volume of songs. There will be a seek bar as well allowing users to begin playing songs at any point during the duration of the song. As a stretch goal, we might implement the ability to like songs to be added into a singular liked playlist, and to be able to create and save custom playlists.

This repository is currently in development.

# Initial Requirements

Please install the following:

- OCaml

**Click on the links below for Operating System specific guides on how to install the above dependencies:**

[Mac OS Installing Initial Requirements guide](#MacOS)

[Windows Installing Initial Requirements guide](#Windows)

<a name="Continue"></a>

# Cloning the respository

To clone (download) the respository onto your local machine. On Windows open WSL (Windows Subsystem for Linux) and run the following command. On Linux or MacOS open terminal and run the command.

```
git clone https://github.com/BYam24/VVeganYam.git
```

# Installing GUI packages

Run the following commands install gui dependencies. On Windows open WSL (Windows Subsystem for Linux) and run the following commands. On Linux or MacOS open terminal and run the commands

```
opam install lablgtk
opam install bogue
```

# Installing audio streaming packages

First install liquidsoap by running:

```
opam install liquidsoap
```

Then install what is recommened by copy and pasting below into terminal:

```
opam install -y mad ffmpeg cry taglib
```

liquidsoap might recommend installing the packages lame and shine. You may do so, however it is not needed.

You can find Bogue documentation here:
https://garrigue.github.io/lablgtk/refdoc/index.html

# Run Otune

After all dependencies are successfully installed, you can run the BaseStation on your
computer and start working with the minibot.

The BaseStation is the intermediary that manages information flow between the minibot and
hardware to the software and GUI. BaseStation runs on `cs-reminibot/basestation/base_station_interface.py` and is a
simple web application that runs on HTTP.

To run the BaseStation, run the following command. You should currently be in the cs-reminibot directory.
**If you want the use the speech recognition feature of the Minibot platform, run this command in your regular terminal (not VSCode terminal). This is because VSCode does not have permission to access your computer's microphone.**

```
./run_BS.sh
```

# Operating System Specific Guides to Install Initial Requirements

[Continue with the remaining installation steps](#Continue)

<a name="MacOS"></a>

# MacOS: Installing Initial Requirements

Beneath the surface, macOS is already a Unix-based OS. But you’re going to need some developer tools and a Unix package manager. There are two to pick from: Homebrew and MacPorts. From the perspective of this textbook and CS 3110, it doesn’t matter which you choose:

If you’re already accustomed to one, feel free to keep using it. Make sure to run its update command before continuing with these instructions.

Otherwise, pick one and follow the installation instructions on its website. The installation process for Homebrew is typically easier and faster, which might nudge you in that direction. If you do choose MacPorts, make sure to follow all the detailed instructions on its page, including XCode and an X11 server. Do not install both Homebrew and MacPorts; they aren’t meant to co-exist. If you change your mind later, make sure to uninstall one before installing the other.

After you’ve finished installing/updating either Homebrew or MacPorts, proceed to Install OPAM, below.

#### Homebrew Installation

1. Press _Cmd + Space_ to open Spotlight Search. Search for Terminal and open it.
2. Visit brew.sh in your browser to install Homebrew. Copy the command specified in the installation section into your terminal and run it.
3. After installation is complete, run the following command in your terminal:

```
brew upgrade
```

### OPAM Installation

Mac. If you’re using Homebrew, run this command:

```
brew install opam
```

If you’re using MacPorts, run this command:

```
sudo port install opam
```

### Initialize OPAM

Linux, Mac, and WSL2. Run:

```
opam init --bare -a -y
```

### Create an OPAM Switch

A switch is a named installation of OCaml with a particular compiler version and set of packages. You can have many switches and, well, switch between them —whence the name. Create a switch for this semester’s CS 3110 by running this command:

```
opam switch create Otune ocaml-base-compiler.4.14.0
```

If that command fails saying that the 4.14.0 compiler can’t be found, you probably installed OPAM sometime back in the past and now need to update it. Do so with opam update.

```
eval $(opam env)
```

Now we need to make sure your OCaml environment was configured correctly. Logout from your OS (or just reboot). Then re-open your terminal and run this command:

```
opam switch list
```

You should get output like this:

```
#  switch         compiler                    description
→  otune  ocaml-base-compiler.4.14.0          otune
```

Continue by install ocaml packages we need:

```
opam install -y utop odoc ounit2 qcheck bisect_ppx menhir ocaml-lsp-server ocamlformat ocamlformat-rpc bogue lablgtk
```

[Continue with the remaining installation steps](#Continue)

<a name="Windows"></a>

### Windows

Unix development in Windows is made possible by the Windows Subsystem for Linux (WSL). If you have a recent version of Windows (build 20262, released November 2020, or newer), WSL is easy to install. If you don’t have that recent of a version, try running Windows Update to get it.

With a recent version of Windows, and assuming you’ve never installed WSL before, here’s all you have to do:

Open Windows PowerShell as Administrator. To do that, click Start, type PowerShell, and it should come up as the best match. Click “Run as Administrator”, and click Yes to allow changes.

Run wsl --install. (Or, if you have already installed WSL but not Ubuntu before, then instead run wsl --install -d Ubuntu.) When the Ubuntu download is completed, it will likely ask you to reboot. Do so. The installation will automatically resume after the reboot.

You will be prompted to create a Unix username and password. You can use any username and password you wish. It has no bearing on your Windows username and password (though you are free to re-use those). Do not put a space in your username. Do not forget your password. You will need it in the future.

### Ubuntu setup:

Without a recent version of Windows, you will need to follow Microsoft’s manual install instructions. WSL2 is preferred over WSL1 by OCaml (and WSL2 offers performance and functionality improvements), so install WSL2 if you can.

Ubuntu setup. These rest of these instructions assume that you installed Ubuntu (20.04) as the Linux distribution. That is the default distribution in WSL. In principle other distributions should work, but might require different commands from this point forward.

Open the Ubuntu app. (It might already be open if you just finished installing WSL.) You will be at the Bash prompt, which looks something like this:

```
user@machine:~$
```

Enable copy-and-paste:

- Click on the Ubuntu icon on the top left of the window.

- Click Properties

- Make sure “Use Ctrl+Shift+C/V as Copy/Paste” is checked.

Now Ctrl+Shift+C will copy and Ctrl+Shift+V will paste into the terminal. Note that you have to include Shift as part of that keystroke.

Run the following command to update the APT package manager, which is what helps to install Unix packages:

sudo apt update
You will be prompted for the Unix password you chose. The prefix sudo means to run the command as the administrator, aka “super user”. In other words, do this command as super user, hence, “sudo”.

Now run this command to upgrade all the APT software packages:

```
sudo apt upgrade -y
```

Then install some useful packages that we will need:

```
sudo apt install -y zip unzip build-essential
```

File Systems. WSL has its own filesystem that is distinct from the Windows file system, though there are ways to access each from the other.

When you launch Ubuntu and get the $ prompt, you are in the WSL file system. Your home directory there is named ~, which is a built-in alias for /home/your_ubuntu_user_name. You can run explorer.exe . (note the dot at the end of that) to open your Ubuntu home directory in Windows explorer.

From Ubuntu, you can access your Windows home directory at the
path

```
/mnt/c/Users/your_windows_user_name/.
```

From Windows Explorer, you can access your Ubuntu home directory under the Linux icon in the left-hand list (near “This PC” and “Network”), then navigating to Ubuntu → home → your_ubuntu_user_name. Or you can go there directly by typing into the Windows Explorer path bar:

```
\\wsl$\Ubuntu\home\your_ubuntu_user_name.
```

### Windows OPAM Installation

Windows. Run this command from Ubuntu:

```
sudo apt install opam
```

WSL2. Run:

```
opam init --bare -a -y
```

It is expected behavior to get a note about making sure .profile is well sourced in .bashrc. You don’t need to do anything about that.

WSL1. Hopefully you are running WSL2, not WSL1. But on WSL1, run:

```
opam init --bare -a -y --disable-sandboxing
```

### Create an OPAM Switch

A switch is a named installation of OCaml with a particular compiler version and set of packages. You can have many switches and, well, switch between them —whence the name. Create a switch for this semester’s CS 3110 by running this command:

```
opam switch create Otune ocaml-base-compiler.4.14.0
```

If that command fails saying that the 4.14.0 compiler can’t be found, you probably installed OPAM sometime back in the past and now need to update it. Do so with opam update.

```
eval $(opam env)
```

Now we need to make sure your OCaml environment was configured correctly. Logout from your OS (or just reboot). Then re-open your terminal and run this command:

```
opam switch list
```

You should get output like this:

```
#  switch         compiler                    description
→  otune  ocaml-base-compiler.4.14.0          otune
```

Continue by install ocaml packages we need:

```
opam install -y utop odoc ounit2 qcheck bisect_ppx menhir ocaml-lsp-server ocamlformat ocamlformat-rpc bogue lablgtk liquidsoap mad ffmpeg lame shine cry taglib
```

[Continue with the remaining installation steps](#Continue)
