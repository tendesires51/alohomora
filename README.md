# Alohomora

A personalized SSH welcome screen (MOTD) generator with a Harry Potter theme.

![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Features

- **Custom ASCII banner** - Your chosen name rendered in FIGlet fonts
- **Configurable colors** - 14 color presets for primary, secondary, and accent colors
- **Local weather** - Current conditions for your city via wttr.in
- **System stats** - Uptime, disk, memory, CPU, and load average
- **Docker status** - Running container count and status
- **Harry Potter splash texts** - 50 rotating magical messages
- **Interactive setup wizard** - Easy 7-step configuration

## Installation

### Option 1: Download and install (recommended)

```bash
# Download the latest release
wget https://github.com/tendesires51/alohomora/releases/latest/download/alohomora_1.0.0_all.deb

# Install
sudo dpkg -i alohomora_1.0.0_all.deb
sudo apt-get install -f  # Install dependencies if needed
```

### Option 2: Build from source

```bash
git clone https://github.com/tendesires51/alohomora.git
cd alohomora
sudo apt install figlet curl
sudo make install
sudo alohomora-setup
```

### Option 3: Build the .deb package yourself

```bash
git clone https://github.com/tendesires51/alohomora.git
cd alohomora
sudo apt install debhelper figlet curl
dpkg-buildpackage -us -uc -b
sudo dpkg -i ../alohomora_1.0.0_all.deb
```

## Configuration

Run the setup wizard:

```bash
sudo alohomora-setup
```

The wizard will guide you through:

1. **Banner name** - Text displayed as ASCII art (max 12 characters)
2. **FIGlet font** - Choose from 6 font styles with previews
3. **Primary color** - Top half of the banner
4. **Secondary color** - Bottom half of the banner
5. **Accent color** - Icons and highlights
6. **Location** - City for weather and timezone
7. **Other MOTDs** - Option to disable existing MOTD scripts

Configuration is saved to `/etc/alohomora/config`.

## Available Colors

`blue` `lightblue` `cyan` `green` `lime` `gold` `amber` `orange` `red` `magenta` `purple` `pink` `white` `gray`

## Uninstall

```bash
# Keep configuration
sudo apt remove alohomora

# Remove everything including configuration
sudo apt purge alohomora
```

## Dependencies

- `figlet` - ASCII art text generation
- `curl` - Weather fetching
- `bash` - Script execution

## License

MIT License - see [LICENSE](LICENSE) for details.

## Credits

Inspired by the Harry Potter series by J.K. Rowling. This project is not affiliated with or endorsed by Warner Bros. or the Harry Potter franchise.
