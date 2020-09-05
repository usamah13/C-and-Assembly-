CFLAGS += -std=gnu11
EXES   =  mymalloc mymalloc_alt
OBJS   =  mymalloc.o mymalloc_alt.o main.o

all: $(EXES)

mymalloc: mymalloc.o main.o
mymalloc_alt: mymalloc_alt.o main.o

clean:
	rm -f $(EXES) $(OBJS)
tidy:
	rm -f $(OBJS)
