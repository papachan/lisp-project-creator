LISP ?= sbcl
NAME ?= create

BINARY=$(HOME)/bin/$(NAME)
SCRIPT=$(PWD)/$(NAME)

.PHONY: all $(NAME) clean

all: $(NAME)

$(NAME):
	$(LISP) --load project-create.asd \
                --eval '(ql:quickload :project-create)' \
                --eval "(sb-ext:save-lisp-and-die #p\"$(NAME)\" :toplevel #'project-create:main :executable t)"


install: $(NAME)
	@ln -sf $(SCRIPT) $(BINARY)
	@$(SCRIPT) symlink $(NAME)

clean:
	@rm -f $(NAME)
