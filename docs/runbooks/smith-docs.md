
# Smith Docs

Documentation is essential to be able to learn from what you are building. The method for documentation is a series of markdown files hosted using Obsidian and MkDocs.

---

## Download and Install Obsidian

Obsidian can be obtained through several methods and since the tech stack is Fedora focused, we wil be covering that.

---

### Install Methods

On Fedora, there are a few methods at our disposal. All of which can be downloaded from this [link](https://github.com/obsidianmd/obsidian-releases/releases).

##### Install Obsidian Using Flatpak (*Recommended*)

This is recommended for most circumstances as the benefits are:

* Automatic Updates
* Desktop Integration
* Simple Installation

Considerations however are:

* Filesystem access is sandboxed (is also a pro)
* Additional permissions may be required using flatpak

```Shell
sudo flatpak install -y flathub md.obsidian.Obsidian
```

Selecting a folder through the file picker grants access via the XDG Portal (`/run/user/.../doc/...`). Using a Flatpak override grants direct access to the actual filesystem path such as `/home/csmith/repos`.

###### View Current Flatpak Filesystem Permissions

```
flatpak info --show-permissions md.obsidian.Obsidian | grep -i filesystems
```

###### Add an Additional Filesystem Permission

Flatpak filesystem overrides are additive. Granting access to another directory does not remove previously granted directories. Use `--reset` to clear all custom overrides.

```
flatpak override --user \
  --filesystem=~/storage/smith-lab/docs \
  md.obsidian.Obsidian
```

###### Reset All Overrides

```
flatpak override --user --reset md.obsidian.Obsidian
```

If not adding an additional filesystem to sandbox permissions, consider `ln -s`.

#### Install Obsidian Using AppImage

Recommended when:

* Testing Obsidian
* Running from removable storage
* Avoiding Flatpak sandboxing

##### x86_64

```Shell
cd ~/Downloads
wget "$(
	curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
	| grep browser_download_url \
	| grep AppImage \
	| grep -v arm64 \
	| cut -d '"' -f 4
)"
chmod +x Obsidian-*.AppImage
./Obsidian-*.AppImage
```

##### aarch64

```Shell
cd ~/Downloads
wget "$(
	curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
	| grep browser_download_url \
	| grep AppImage \
	| grep arm64 \
	| cut -d '"' -f 4
)"
chmod +x Obsidian-*.AppImage
./Obsidian-*.AppImage
```

#### Install Using Tar Archive

Recommended when:

* Building a portable project bundle
* Managing software manually
* Avoiding Flatpak dependencies

##### x86_64

```Shell
cd ~/Downloads
wget "$(
	curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
	| grep browser_download_url \
	| grep tar.gz \
	| grep -v arm64 \
	| cut -d '"' -f 4
)"
tar -xzf obsidian-*.tar.gz
rm -rf obsidian-*.tar.gz
cd obsidian-*/
./obsidian
```

##### aarch64

```Shell
cd ~/Downloads
wget "$(
	curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
	| grep browser_download_url \
	| grep tar.gz \
	| grep arm64 \
	| cut -d '"' -f 4
)"
tar -xzf obsidian-*.tar.gz
rm -rf obsidian-*.tar.gz
cd obsidian-*/
./obsidian
```

---

## Test
