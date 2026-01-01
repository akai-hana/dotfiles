###           akai's xstow Makefile! ~           ###
### MAKE SURE TO EXECUTE WITH ROOT PERMISSION!!! ###

# ---

# DEFINITIONS #

# home directory
## automatic detection
#HOME = $$HOME
## manually-defined
HOME  = /home/akai

# dotfiles directory (to be taken by xstow)
DOTFILES = chimera

# verbosity [0-3] (0 = disabled, 3 = max verbosity)
VERBOSE_LEVEL = 3

### explicitly declare phonies for portability across GNU make and bmake
.PHONY: help install uninstall test

### setting phony to $(MAKECMDGOALS) unfortunately isn't POSIX-compatible, so
### declaring manually, although crude, is the most cross-compatible solution.

# palette
CYAN    = \033[0;36m
GREEN   = \033[0;32m
YELLOW  = \033[0;33m
RED     = \033[0;31m
BOLD    = \033[1m
RESET   = \033[0m

# ---

# ROOT CHECK MACRO
# bmake doesn't support define/endef, so we use a shell variable
CHECK_ROOT = \
						 if [ "$$(id -u)" -ne 0 ]; then \
						 printf "$(RED)$(BOLD)Error: Root permissions required!$(RESET)\n"; \
						 printf "\n"; \
						 printf "$(YELLOW)Please run with: doas bmake $$@$(RESET)\n"; \
						 printf "$(YELLOW)             or: sudo bmake $$@$(RESET)\n"; \
						 printf "$(YELLOW)... or simply logged in as a root user.$(RESET)\n"; \
						 printf "\n"; \
						 exit 1; \
						 fi

# ---

# MAIN LOGIC #

# formatting wrapper
RUN = sh formatting_wrapper.sh

# help (default target)
help:
	@printf "$(BOLD)akai's xstow Makefile! :>$(RESET)\n"
	@printf "\n"
	@printf "$(CYAN)current definitions:$(RESET)\n"
	@printf "  $(GREEN)\$$DOTFILES directory$(RESET) -> \`$(DOTFILES)\`\n"
	@printf "  $(GREEN)\$$HOME directory$(RESET)     -> \`$(HOME)\`\n"
	@printf "\n"
	@printf "$(CYAN)available targets:$(RESET)\n"
	@printf "  $(GREEN)install$(RESET)   -> stows dotfiles to \$$HOME, /usr and /etc\n"
	@printf "  $(GREEN)uninstall$(RESET) -> Remove all stowed symlinks\n"
	@printf "  $(GREEN)test$(RESET)      -> Dry-run (test without making changes)\n"
	@printf "  $(GREEN)help$(RESET)      -> Show this help message\n"
	@printf "\n"
	@printf "$(YELLOW)note: make sure to run with root permissions$(RESET)\n"

# stow
## stows /etc and /usr individually, since these are outside of $HOME
install:
	@$(CHECK_ROOT)
	@printf "$(CYAN)-> Stowing $(DOTFILES) onto $(HOME)$(RESET)\n"
	@$(RUN) xstow --target=$(HOME) $(DOTFILES) --verbose=$(VERBOSE_LEVEL)
	@printf "$(CYAN)-> Stowing $(DOTFILES) onto /etc$(RESET)\n"
	@$(RUN) xstow --target=/etc $(DOTFILES)/etc --verbose=$(VERBOSE_LEVEL)
	@printf "$(CYAN)-> Stowing $(DOTFILES) onto /usr$(RESET)\n"
	@$(RUN) xstow --target=/usr $(DOTFILES)/usr --verbose=$(VERBOSE_LEVEL)
	@printf "$(CYAN)-> Stowing $(DOTFILES) onto /dev$(RESET)\n"
	@$(RUN) xstow --target=/dev $(DOTFILES)/dev --verbose=$(VERBOSE_LEVEL)

# kaboom
## first /usr, then /etc, to avoid issues with doas.conf
uninstall:
	@$(CHECK_ROOT)
	@printf "$(CYAN)-> Unstowing $(DOTFILES) from $(HOME)$(RESET)\n"
	@$(RUN) xstow --target=$(HOME) --delete $(DOTFILES) --verbose=$(VERBOSE_LEVEL)
	@printf "$(CYAN)-> Unstowing $(DOTFILES) from /usr$(RESET)\n"
	@$(RUN) xstow --target=/usr --delete $(DOTFILES)/usr --verbose=$(VERBOSE_LEVEL)
	@printf "$(CYAN)-> Unstowing $(DOTFILES) from /etc$(RESET)\n"
	@$(RUN) xstow --target=/etc --delete $(DOTFILES)/etc --verbose=$(VERBOSE_LEVEL)

# dry-run (adding/testing xstow before committing)
test:
	@$(CHECK_ROOT)
	@printf "$(CYAN)-> Dry-run stowing $(DOTFILES) onto $(HOME)$(RESET)\n"
	@$(RUN) xstow --target=$(HOME) --no $(DOTFILES) --verbose=$(VERBOSE_LEVEL)
	@printf "$(CYAN)-> Dry-run stowing $(DOTFILES) onto /usr$(RESET)\n"
	@$(RUN) xstow --target=/usr --no $(DOTFILES)/usr --verbose=$(VERBOSE_LEVEL)
	@printf "$(CYAN)-> Dry-run stowing $(DOTFILES) onto /etc$(RESET)\n"
	@$(RUN) xstow --target=/etc --no $(DOTFILES)/etc --verbose=$(VERBOSE_LEVEL)
