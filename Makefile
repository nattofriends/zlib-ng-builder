export VERSION := 2.1.6

package:
	./build.sh

clean:
	rm -rf zlib-ng
	rm -rf *.deb
