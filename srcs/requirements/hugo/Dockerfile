FROM debian:oldstable

# Update and install
RUN apt-get update && apt-get upgrade && apt install -y \
	hugo git

# Create a new website, cd into the website root, download them
RUN hugo new site /var/hugo/static && \
	cd /var/hugo/static && \
	git clone https://github.com/MeiK2333/github-style themes/github-style && \
	hugo -b https://gda-cruz.42.fr/static


COPY ./conf/config.toml /var/hugo/static/config.toml
COPY conf/avatar.jpg /var/hugo/me/themes/github-style/static/avatar.jpg

EXPOSE 1313

WORKDIR /var/hugo/static

CMD ["hugo", "server", \
	"--bind=0.0.0.0", \
	"--baseURL=https://gda-cruz.42.fr/static", \
	"-p", "1313", \
	"--logFile=/dev/stdout", \
	"--appendPort=false"]