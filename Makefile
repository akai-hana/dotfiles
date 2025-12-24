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

# Colors
CYAN    = \033[0;36m
GREEN   = \033[0;32m
YELLOW  = \033[0;33m
BOLD    = \033[1m
RESET   = \033[0m

# ---

# MAIN LOGIC #

# formatting wrapper
RUN = sh formatting_wrapper.sh

# main stow function
stow = $(RUN) xstow --target=$(1) $(2) --verbose=$(VERBOSE_LEVEL) # do not force this

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
	@echo -e "$(CYAN)-> Stowing $(DOTFILES) onto $(HOME)$(RESET)"
	@$(call stow,$(HOME),$(DOTFILES))
	@echo -e "$(CYAN)-> Stowing $(DOTFILES) onto /usr$(RESET)"
	@$(call stow,/usr,$(DOTFILES)/usr)
	@echo -e "$(CYAN)-> Stowing $(DOTFILES) onto /etc$(RESET)"
	@$(call stow,/etc,$(DOTFILES)/etc)

# kaboom
## first /usr, then /etc, to avoid issues with doas.conf
uninstall:
	@echo -e "$(CYAN)-> Unstowing $(DOTFILES) from $(HOME)$(RESET)"
	@$(call stow,$(HOME),--delete $(DOTFILES))
	@echo -e "$(CYAN)-> Unstowing $(DOTFILES) from /usr$(RESET)"
	@$(call stow,/usr,--delete $(DOTFILES)/usr)
	@echo -e "$(CYAN)-> Unstowing $(DOTFILES) from /etc$(RESET)"
	@$(call stow,/etc,--delete $(DOTFILES)/etc)

# dry-run (adding/testing xstow before committing)
test:
	@echo -e "$(CYAN)-> Dry-run stowing $(DOTFILES) onto $(HOME)$(RESET)"
	@$(call stow,$(HOME),--no $(DOTFILES))
	@echo -e "$(CYAN)-> Dry-run stowing $(DOTFILES) onto /usr$(RESET)"
	@$(call stow,/usr,--no $(DOTFILES)/usr)
	@echo -e "$(CYAN)-> Dry-run stowing $(DOTFILES) onto /etc$(RESET)"
	@$(call stow,/etc,--no $(DOTFILES)/etc)
