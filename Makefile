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

## the double dollar sign serves as an escape sequence for itself,
## to mean "HOME" as in the shell variable, not as in a Make variable
## (ej. $H + OME)
## `$(DOTFILES)` only uses one $ since it's a Make variable, not a shell one.

### little hack to declare all arguments of the "make" command as phonies,
### to not have to do so manually for each target defined in this Makefile
### (ej. `.PHONY: install uninstall dry_run <yada> <yada>`)
.PHONY: $(MAKECMDGOALS)

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
		echo -e "$(RED)$(BOLD)Error: Root permissions required!$(RESET)"; \
		echo ""; \
		echo -e "$(YELLOW)Please run with: doas bmake $@$(RESET)"; \
		echo -e "$(YELLOW)             or: sudo bmake $@$(RESET)"; \
		echo -e "$(YELLOW)... or simply logged in as a root user.$(RESET)"; \
		echo ""; \
		exit 1; \
	fi

# ---

# MAIN LOGIC #

# formatting wrapper
RUN = sh formatting_wrapper.sh

# help (default target)
help:
	@echo -e "$(BOLD)akai's xstow Makefile! :>$(RESET)"
	@echo ""
	@echo -e "$(CYAN)current definitions:$(RESET)"
	@echo -e "  $(GREEN)\$$DOTFILES directory$(RESET) -> \`$(DOTFILES)\`"
	@echo -e "  $(GREEN)\$$HOME directory$(RESET)     -> \`$(HOME)\`"
	@echo ""
	@echo -e "$(CYAN)available targets:$(RESET)"
	@echo -e "  $(GREEN)install$(RESET)   -> stows dotfiles to \$$HOME, /usr and /etc"
	@echo -e "  $(GREEN)uninstall$(RESET) -> Remove all stowed symlinks"
	@echo -e "  $(GREEN)test$(RESET)      -> Dry-run (test without making changes)"
	@echo -e "  $(GREEN)help$(RESET)      -> Show this help message"
	@echo ""
	@echo -e "$(YELLOW)note: make sure to run with root permissions$(RESET)"

# stow
## stows /etc and /usr individually, since these are outside of $HOME
install:
	@$(CHECK_ROOT)
	@echo -e "$(CYAN)-> Stowing $(DOTFILES) onto $(HOME)$(RESET)"
	@$(RUN) xstow --target=$(HOME) $(DOTFILES) --verbose=$(VERBOSE_LEVEL)
	@echo -e "$(CYAN)-> Stowing $(DOTFILES) onto /usr$(RESET)"
	@$(RUN) xstow --target=/usr $(DOTFILES)/usr --verbose=$(VERBOSE_LEVEL)
	@echo -e "$(CYAN)-> Stowing $(DOTFILES) onto /etc$(RESET)"
	@$(RUN) xstow --target=/etc $(DOTFILES)/etc --verbose=$(VERBOSE_LEVEL)

# kaboom
## first /usr, then /etc, to avoid issues with doas.conf
uninstall:
	@$(CHECK_ROOT)
	@echo -e "$(CYAN)-> Unstowing $(DOTFILES) from $(HOME)$(RESET)"
	@$(RUN) xstow --target=$(HOME) --delete $(DOTFILES) --verbose=$(VERBOSE_LEVEL)
	@echo -e "$(CYAN)-> Unstowing $(DOTFILES) from /usr$(RESET)"
	@$(RUN) xstow --target=/usr --delete $(DOTFILES)/usr --verbose=$(VERBOSE_LEVEL)
	@echo -e "$(CYAN)-> Unstowing $(DOTFILES) from /etc$(RESET)"
	@$(RUN) xstow --target=/etc --delete $(DOTFILES)/etc --verbose=$(VERBOSE_LEVEL)

# dry-run (adding/testing xstow before committing)
test:
	@$(CHECK_ROOT)
	@echo -e "$(CYAN)-> Dry-run stowing $(DOTFILES) onto $(HOME)$(RESET)"
	@$(RUN) xstow --target=$(HOME) --no $(DOTFILES) --verbose=$(VERBOSE_LEVEL)
	@echo -e "$(CYAN)-> Dry-run stowing $(DOTFILES) onto /usr$(RESET)"
	@$(RUN) xstow --target=/usr --no $(DOTFILES)/usr --verbose=$(VERBOSE_LEVEL)
	@echo -e "$(CYAN)-> Dry-run stowing $(DOTFILES) onto /etc$(RESET)"
	@$(RUN) xstow --target=/etc --no $(DOTFILES)/etc --verbose=$(VERBOSE_LEVEL)
