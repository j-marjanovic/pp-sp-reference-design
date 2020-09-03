

all: test_IDT8NxQ001

test_IDT8NxQ001: obj/IDT8NxQ001.o obj/seatest.o test_IDT8NxQ001.c
	gcc -o $@ $^

obj/seatest.o: seatest/seatest.c obj
	gcc -Wall -Wextra -c -o $@ $<

obj/IDT8NxQ001.o: ../src/IDT8NxQ001.c
	gcc -Wall -Wextra -c -o $@ $<

obj:
	mkdir obj

clean:
	rm -f test_IDT8NxQ001 seatest.o
