#
# Makefile:
#	wiringPi - A "wiring" library for the Raspberry Pi
#	https://projects.drogon.net/wiring-pi
#
#	Copyright (c) 2012-2015 Gordon Henderson
#################################################################################
# This file is part of wiringPi:
#	Wiring Compatable library for the Raspberry Pi
#
#    wiringPi is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    wiringPi is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
#################################################################################

ifneq ($V,1)
Q ?= @
endif

#DEBUG	= -g -O0
DEBUG	= -O3
CC	= g++
INCLUDE	= -I/usr/local/include
CFLAGS	= $(DEBUG) -Wall $(INCLUDE) -Winline -pipe

LDFLAGS	= -L/usr/local/lib
LDLIBS    = -lwiringPi -lwiringPiDev -lpthread -lm -lcrypt -lrt

# Should not alter anything below this line
###############################################################################

SRC	= encoder.cpp \
	  encoderTest.cpp \
	  digitalTest.cpp

OBJ	=	$(SRC:.cpp=.o)

BINS	= encoderTest 

view-all:	
	$Q echo "OBJ=$(OBJ)" | fmt
	$Q echo "BINS=$(BINS)" | fmt
	$Q echo ""

all:	$(BINS)

	
encoderTest: $(OBJ)
	$(CC) encoder.o encoderTest.o -o encoderTest $(LDFLAGS) $(LDLIBS)
 
digitalTest: digitalTest.o
	$(CC) digitalTest.o -o digitalTest $(LDFLAGS) $(LDLIBS)
 

.cpp.o:
	$Q echo [CC] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@
