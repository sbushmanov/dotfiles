COMPOSED=emoji.compose modletters.compose tags.compose maths.compose
all: $(COMPOSED)

%.compose: %-base emojitrans2.pl
	./emojitrans2.pl < $< > $@

clean:
	rm -f $(COMPOSED)
