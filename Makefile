#
# Makefile
# Ye Chang, 2020-04-14 15:55
#

all: demo
	@echo "Finished all!"

demo:
	@echo -e "\t---> runing demo..."
	@./md2html.sh example/report.md # 2>/dev/null
	@echo -e "\t---> html generated."

# vim:ft=make
#
