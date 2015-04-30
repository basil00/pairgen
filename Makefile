
CC = clang -std=gnu99
CFLAGS = -Isecp256k1/ -Isecp256k1/src/ -O3 --save-temps -fomit-frame-pointer \
    -ffast-math -DLINUX 
OBJS = pairgen.o 

pairgen: $(OBJS)
	$(CC) -o pairgen $(OBJS) -lgmp -lm -lpthread
	strip pairgen

profile: CC = gcc -pg --std=gnu99 -DLINUX
profile: CFLAGS = -Isecp256k1/ -Isecp256k1/src/ -O1
profile: $(OBJS)
	$(CC) -o pairgen $(OBJS) -lgmp -lm -lpthread

debug: CC = gcc --std=gnu99 -DLINUX
debug: CFLAGS = -Isecp256k1/ -Isecp256k1/src/ -O0 -g
debug: $(OBJS)
	$(CC) -o pairgen $(OBJS) -lgmp -lm -lpthread

clean:
	rm -f $(OBJS) pairgen

