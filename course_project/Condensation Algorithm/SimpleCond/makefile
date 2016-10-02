# To compile on a Windows machine, remove the -DANSI_TERM_SEQUENCES
# from CCOPTS

OBJECTS = utility.o model_specific.o condensation.o

LIBRARIES = -lm

TARGET = condense
TARGETDEPS = $(OBJECTS)

CC = cc
# To compile on a Windows machine, remove the -DANSI_TERM_SEQUENCES
CCOPTS = -DANSI_TERM_SEQUENCES -g

$(TARGET): $(TARGETDEPS)
	$(CC) -o $(TARGET) $(TARGETDEPS) $(LIBRARIES)

# Basic C rules
%.o:%.c
	$(CC) -c $< $(INCLUDES) $(CCOPTS)

# Changing the parameters requires a recompilation
model_specific.o: model_parameters.h
condense.o: model_parameters.h

clean:
	rm -f $(OBJECTS)
	rm -f $(TARGET)
	rm -f *~
