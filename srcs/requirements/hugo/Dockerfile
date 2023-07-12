FROM debian:oldstable

WORKDIR /var/hugo/static/

# Update and install
RUN apt-get update && apt-get upgrade && apt install -y \
	hugo git

# Create a new website, cd into the website root, download them
RUN hugo new site /var/hugo/static && \
	cd /var/hugo/static && \
	git clone https://github.com/526avijitgupta/gokarna.git themes/gokarna && \
	hugo -b https://gda-cruz.42.fr/static

# Copy the content into the relevant directories
COPY ./conf/config.toml /var/hugo/static/config.toml
COPY ./content/torch.webp /var/hugo/static/static/images/torch.webp
COPY ./content/potatoes.png /var/hugo/static/static/images/potatoes.png
COPY ./content/index-about.md /var/hugo/static/content/index-about.md
COPY ./content/index.md /var/hugo/static/content/about/index.md


EXPOSE 1313

CMD [ "hugo", "server", \
	"--bind=0.0.0.0", \
	"--baseURL=https://gda-cruz.42.fr/static", \
	"-p", "1313", \
	"--logFile=/dev/stdout", \
	"--appendPort=false" ]