install:
	cp systemd/docker-netns@.service /etc/systemd/system/docker-netns@.service
	cp docker-netns-service /usr/local/bin/docker-netns-service
	systemctl daemon-reload

uninstall:
	rm /etc/systemd/system/docker-netns@.service
	rm /usr/local/bin/docker-netns-service
