#
# Makefile
# Ye Chang, 2020-04-14 15:55
#

all: html
	@echo "Finished all!"

html:
	@./md2html.sh example/report.md
	@echo "---> html generated."

# vim:ft=make
#
