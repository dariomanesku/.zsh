all:
	ln -s ~/.zsh/.zshrc ~/.zshrc > /dev/null 2>&1 || true
	@echo Done.

install:
	cd ~/.zsh
	git submodule init
	git submodule update
	cp ~/.zsh/dario.zsh-theme ~/.zsh/oh-my-zsh/themes/
