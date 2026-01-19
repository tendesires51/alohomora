# Alohomora Makefile
# For building and installing the MOTD generator

PACKAGE = alohomora
VERSION = 1.0.0

PREFIX ?= /usr
DESTDIR ?=

INSTALL_DIR = $(DESTDIR)$(PREFIX)/share/alohomora
BIN_DIR = $(DESTDIR)$(PREFIX)/bin
CONFIG_DIR = $(DESTDIR)/etc/alohomora
MOTD_DIR = $(DESTDIR)/etc/update-motd.d

.PHONY: all install uninstall clean deb

all:
	@echo "Alohomora - Personalized SSH Welcome Script"
	@echo ""
	@echo "Available targets:"
	@echo "  make install    - Install to system (requires root)"
	@echo "  make uninstall  - Remove from system (requires root)"
	@echo "  make deb        - Build Debian package"
	@echo "  make clean      - Clean build artifacts"

install:
	@echo "Installing Alohomora..."

	# Create directories
	install -d $(INSTALL_DIR)
	install -d $(BIN_DIR)
	install -d $(CONFIG_DIR)

	# Install scripts (with CRLF to LF conversion for Windows compatibility)
	sed 's/\r$$//' src/alohomora-setup > $(INSTALL_DIR)/alohomora-setup
	chmod 755 $(INSTALL_DIR)/alohomora-setup
	sed 's/\r$$//' src/alohomora-motd > $(INSTALL_DIR)/alohomora-motd
	chmod 755 $(INSTALL_DIR)/alohomora-motd

	# Install splash texts (with CRLF to LF conversion)
	sed 's/\r$$//' src/splash-texts.txt > $(INSTALL_DIR)/splash-texts.txt
	chmod 644 $(INSTALL_DIR)/splash-texts.txt

	# Create symlinks
	ln -sf $(PREFIX)/share/alohomora/alohomora-setup $(BIN_DIR)/alohomora-setup

	# Link to update-motd.d if it exists
	if [ -d /etc/update-motd.d ]; then \
		ln -sf $(PREFIX)/share/alohomora/alohomora-motd $(MOTD_DIR)/99-alohomora; \
	fi

	@echo ""
	@echo "Installation complete!"
	@echo "Run 'sudo alohomora-setup' to configure your MOTD."

uninstall:
	@echo "Uninstalling Alohomora..."

	# Remove MOTD link
	rm -f $(MOTD_DIR)/99-alohomora

	# Remove bin symlink
	rm -f $(BIN_DIR)/alohomora-setup

	# Remove install directory
	rm -rf $(INSTALL_DIR)

	# Optionally remove config (user must do this manually to preserve settings)
	@echo ""
	@echo "Uninstall complete."
	@echo "Config files in /etc/alohomora were preserved."
	@echo "To remove them: sudo rm -rf /etc/alohomora"

clean:
	rm -rf build/
	rm -f *.deb

deb:
	@echo "Building Debian package..."
	dpkg-buildpackage -us -uc -b
	@echo ""
	@echo "Package built! Look for .deb file in parent directory."
