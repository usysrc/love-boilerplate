# credit goes to vrld
# source: https://love2d.org/forums/viewtopic.php?f=3&t=3620&start=20#p47895
love=/Applications/love.app/Contents/MacOS/love
zip=zip
create-dmg=create-dmg

builddir=../bin/build/
distdir=../bin/

windir=~/dist/love-11.4-win64
osxapp=~/dist/love.app/

game=GAMENAME
sources=main.lua src/**/*.lua libs/**/*.lua **/*.lua *.lua
res=img/*.* music/*.* sfx/*.*

.PHONY : run test love clean win

run : test
	$(love) .

dist : love win osx

love : $(builddir)/$(game).love
	cp $(builddir)/$(game).love $(distdir)/$(game).love

osx : $(builddir)/$(game).app
	cd $(builddir); \
		create-dmg $(game).dmg ./osx/ ; \
		$(zip) -9 -q ../$(distdir)/$(game)[osx].zip $(game).dmg

win : $(builddir)/$(game).exe
	cd $(builddir); \
		cp $(windir)/*.dll .; \
		$(zip) -q ../$(distdir)/$(game)[win].zip $(game).exe *.dll; \
		rm *.dll

$(builddir)/$(game).app : $(builddir)/$(game).love
	cp -a $(osxapp) $(builddir)/$(game).app
	mkdir -p $(builddir)/osx
	cp $(builddir)/$(game).love $(builddir)/$(game).app/Contents/Resources/
	mv $(builddir)/$(game).app $(builddir)/osx/

$(builddir)/$(game).exe : $(builddir)/$(game).love
	cat $(windir)/love.exe $(builddir)/$(game).love > $(builddir)/$(game).exe

$(builddir)/$(game).love : $(sources) $(res)
	mkdir -p $(builddir)
	$(zip) $(builddir)/$(game).love $(sources) $(res)

clean :
	rm -rf $(builddir)/* $(distdir)/*
